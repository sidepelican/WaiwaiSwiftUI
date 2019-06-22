わいわいswiftc #12

# SwiftUI: 更新検知と値の生存期間

<div style="text-align:right">@iceman5499</div>

---

## SwiftUIにはViewのプロパティの更新を検知するための@propertyDelegateがたくさんある

- @State
- @Binding
- @ObjectBinding
- @EnvironmentObject
- @Environment

(@GestureStateもあるけど今回は未調査)

---

任意の型を入れられるものと、 `BindableObject` を入れるものと2種類がある

| 名前 | 中に入る型 |
|---|---|
| @State | T |
| @Binding | T |
| @ObjectBinding | T: BindableObject |
| @EnvironmentObject |  T: BindableObject |
| @Environment | T |

@Stateなどは任意の型を使用できるが、
struct・enumとclassとで挙動が異なる（後述）
### 順にみていく

---

# @State

---

# @State

値を保持できる。値が変化したとき値を使用したViewがリビルドされる

```
struct StateBasic : View {
    @State var count: Int = 0
    
    var body: some View {
        VStack {
            Text("\(count)")
            Button(action: { // ボタンを押すと表示が更新
                self.count += 1
            }) {
                Text("inc")
            }
        }
    }
}
```

---

# @State

- 値は1つのNavigation単位で生存する
  - Backで画面が消えると初期化される
- **Presentationされていた場合は画面が消えても値が残る**

---

# @State

- View.body内で**値が1度も取り出されなかった場合、値が更新されてもそのViewはリビルドされない**

---

```swift
struct StateUnused : View {
    @State var okane: Int = 0

    var body: some View {
        VStack {
            if AccountManager.shared.isPurchased {
            // 初回でここに入らなかった場合は
            // 以降okaneが変化してもリビルドされない
                Text("\(okane)")
            } else {
                Text("not purchased")
            }
            Button(action: {
                AccountManager.shared.isPurchased = true
                self.okane += 1
            }) {
                Text("purchase")
            }
        }
    }
}
```

---

修正後

```swift
struct StateUnusedFix : View {
    @ObjectBinding var accountManager: AccountManager
    @State var okane: Int = 0

    var body: some View {
        VStack {
            if accountManager.isPurchased {
                Text("\(okane)")
            } else {
                Text("not purchased")
            }
            Button(action: {
                self.accountManager.isPurchased = true
                self.okane += 1
            }) {
                Text("purchase")
            }
        }
    }
}
```

propertyDelegateで監視されていない値を使って分岐をしてはいけない

---

# @State

- 中の値がclassのときは値の保持はされるが更新検知はされない
- enumは更新検知される

---

# @Binding

---

# @Binding

プロパティに対するエイリアスのようなもの

実体は持たないが値を取り出せるし値を変化させれば依存している各所がリビルドされる

---

```swift
private struct IncButton: View {
    @Binding var count: Int

    var body: some View {
        Button(action: {
            self.count += 1
        }) {
            Text("inc")
        }
    }
}

struct BindingBasic : View {
    @State var count = 0

    var body: some View {
        VStack {
            Text("\(count)")
            // ↓ 値への参照を渡して更新してもらう
            IncButton(count: $count)
        }
    }
}
```

---

# @Binding

- うまく使えばリビルド範囲を制御できるかもしれない？
- リビルド範囲を狭めることでパフォーマンスに恩恵があるかは不明

```swift
struct BindingSibling : View {
    @State var count = 0

    var body: some View {
        // countが変化してもこれ自体はリビルドされない
        VStack {
            CounterView(count: $count) // ←この中はリビルド
            IncButton(count: $count)
        }
    }
}
```

---

# @ObjectBinding

---

# @ObjectBinding

@Stateではclassオブジェクトの更新検知ができなかったが、
`BindableObject` に適合させて@ObjectBindingを使用することで更新検知できるようになる

```swift
public protocol BindableObject : 
    AnyObject, // ← 注目！
    DynamicViewProperty,
    Identifiable,
    _BindableObjectViewProperty 
{
    associatedtype PublisherType : Publisher
        where Self.PublisherType.Failure == Never

    var didChange: Self.PublisherType { get }
}
```

---

- それらしい使い方だが、これは罠にはまる

```swift
class CountViewModel: BindableObject {
    let didChange = 
            PassthroughSubject<CountViewModel, Never>()
    var count: Int = 0
    func inc() {
        count += 1
        didChange.send(self)
    }
}

struct ObjectBindingBasic : View {
    @ObjectBinding var viewModel = CountViewModel()
    
    var body: some View {
        VStack {
            Text("\(viewModel.count)")
            Button(action: {
                self.viewModel.inc()
            }) { Text("inc") }
        }
    }
}
```

---

# @ObjectBinding

- 値の保持は**されない**
  - Viewがリビルドされるたびに**値が初期化**される
  - 前ページのコードの場合、ネストした画面で使用されて親Viewがリビルドを発火したタイミングでcountが0に戻る
- それなのに更新検知対象は初回に生成されたオブジェクトのみ
  - 初回生成されたやつはどこかに保持され一生触れない
  - バグっぽい
- Navigation単位ではなぜか値が保持される


- 最も挙動が不安定

---

#### 回避策
- viewModelを@Stateとして保持することでNavigation単位で生存させ、onReceiveで更新を受け取る

```swift
struct ObjectBindingBasicFix : View {
    @State var viewModel = CountViewModel()

    var body: some View {
        VStack {
            Text("\(viewModel.count)")
            Button(action: {
                self.viewModel.inc()
            }) { Text("inc") }
        }
        .onReceive(viewModel.didChange) { viewModel in
            self.viewModel = viewModel
        }
    }
}
```

---

# @EnvironmentObject

---

# @EnvironmentObject

親や祖父やその先の祖先で宣言されたオブジェクトを一気にジャンプして子Viewが取得できる仕組み

- Flutterでいう `InheritedWidget` に近い

---

# @EnvironmentObject

```swift
struct CounterPage: View {
    @EnvironmentObject var counter: CounterEnvironment

    var body: some View {
        // counterが利用できる or 実行時クラッシュ
        ... 
    }
}

struct EnvironmentObjectBasic : View {
    var body: some View {
        VStack {
            CounterPage()
            CounterPage()
        }
        .environmentObject(CounterEnvironment()) // ⭐
    }
}

```

⭐ の行がなければ実行時クラッシュする

---

- **画面単位でしか生存していない**ので、NavigationかPresentationをまたぐとリセットされる

```swift
struct EnvironmentObjectPush : View {
    var body: some View {
        VStack {
            // どちらもボタンタップでクラッシュする
            NavigationButton(destination: CounterPage()) {
                Text("push")
            }
            PresentationButton(destination: CounterPage()) {
                Text("present")
            }
        }
            .environmentObject(CounterEnvironment())
    }
}
```

---

# @Environment

---

# @Environment

EnvironmentObjectと似ていてこちらは値型を扱うといったイメージ。EnvironmentObjectとは異なり `.environment(..., ...)` が宣言されていなくてもデフォルト値が使用されるためクラッシュしない

---

# @Environment

- まず `EnvironmentValues` に値を生やす

```swift
extension EnvironmentValues {
    var counter: CounterEnvironment {
        get { self[CounterEnvironment.self] }
        set { self[CounterEnvironment.self] = newValue }
    }
}

struct CounterEnvironment: EnvironmentKey {
    static var defaultValue: CounterEnvironment {.init()}
    var count: Int = 0
}
```

---

- その後@Environmentと取り出したいプロパティのkeyPathをわたして取り出す

```swift
struct CounterPage2: View {
    @Environment(\.counter) var counter: CounterEnvironment

    var body: some View {
        VStack {
            Text("\(counter.count)")
            Button(action: {
                // Environmentはget-onlyなため変更できない
            }) { Text("inc") }
        }
    }
}
```

---

# @Environment

- @EnvironmentObjectと同様に**画面単位でしか生存していない**ので、NavigationかPresentationをまたぐとデフォルト値が利用される

---

# 生存期間まとめ

| 名前 | 生存期間 |
|---|---|
| @State | Navigation単位。Presentationでは値が残る |
| @Binding | 参照先のオブジェクトと同じ |
| @ObjectBinding | 挙動が不安定だが基本生存しないがち |
| @EnvironmentObject | Navigation・Presentation単位 |
| @Environment | Navigation・Presentation単位 |

- あくまで現時点。リリースされるころには変わってそう

---

# まとめ

- 値の更新でViewがリビルドされるよう暗黙の更新検知に気をつかって実装すること
- Viewに紐付くプロパティの生存期間は思った以上に複雑
- MVVMとかでviewModelなどをくっつけるときは、**viewModelの生成・破棄が予期せぬタイミングで何度も起こる**ことに注意する
  - 特にsubscribeしただけで通信を発火するみたいな実装をしていると大変なことになるかもしれない・・・・

# 環境
- macOS Catalina 10.15 Beta（19A487l）
- Xcode Version 11.0 beta 2 (11M337n)