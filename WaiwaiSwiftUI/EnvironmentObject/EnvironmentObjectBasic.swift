//
//  EnvironmentObjectBasic.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/22.
//  Copyright © 2019 iceman. All rights reserved.
//

import Combine
import SwiftUI

class CounterEnvironmentObject: BindableObject {
    let willChange = PassthroughSubject<CounterEnvironmentObject, Never>()
    var count: Int = 0 {
        willSet {
            willChange.send(self)
        }
    }

    func inc() {
        count += 1
    }
}

struct CounterPage: View {
    @EnvironmentObject var counter: CounterEnvironmentObject

    var body: some View {
        VStack {
            Text("\(counter.count)")
            Button(action: {
                self.counter.inc()
            }) { Text("inc") }
        }
    }
}

//
// ツリーをジャンプして一気に下のViewへ何らかのオブジェクトを渡すことができる
//
struct EnvironmentObjectBasic : View {
    var body: some View {
        VStack {
            CounterPage()
            CounterPage()
        }
            .environmentObject(CounterEnvironmentObject()) // この行がなければ実行時クラッシュ
    }
}

#if DEBUG
struct EnvironmentObjectBasic_Previews : PreviewProvider {
    static var previews: some View {
        EnvironmentObjectBasic()
    }
}
#endif
