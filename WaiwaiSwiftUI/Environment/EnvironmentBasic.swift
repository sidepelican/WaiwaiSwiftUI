//
//  EnvironmentBasic.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/22.
//  Copyright © 2019 iceman. All rights reserved.
//

import SwiftUI

//
// まずはEnvironmentValuesに値を登録できるようにする
//
extension EnvironmentValues {
    var counter: CounterEnvironment {
        get { self[CounterEnvironmentKey.self] }
        set { self[CounterEnvironmentKey.self] = newValue }
    }
}

struct CounterEnvironmentKey: EnvironmentKey {
    static var defaultValue: CounterEnvironment { .init() }
}

struct CounterEnvironment {
    var count: Int = 0
}

//
// EnvironmentObjectとは異なりEnvironmentが定義されてなくてもデフォルト値が使用されるためクラッシュしない
//
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

struct EnvironmentBasic : View {
    var body: some View {
        VStack {
            VStack {
                CounterPage2()
                CounterPage2()
                    .environment(\.counter, CounterEnvironment(count: 2))
                }
                .environment(\.counter, CounterEnvironment(count: 1)) // この行がなくてもデフォルト値が使用される
            CounterPage2()
        }
    }
}

#if DEBUG
struct EnvironmentBasic_Previews : PreviewProvider {
    static var previews: some View {
        EnvironmentBasic()
    }
}
#endif
