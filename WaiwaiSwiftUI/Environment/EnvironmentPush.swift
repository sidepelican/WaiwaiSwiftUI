//
//  EnvironmentPush.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/23.
//  Copyright © 2019 iceman. All rights reserved.
//

import SwiftUI

//
// EnvironmentObjectと同様、値は画面をまたぐと初期化されるのでこの方法で指定してもどちらもデフォルト値(count=0)が使用される
//
struct EnvironmentPush : View {
    var body: some View {
        VStack {
            NavigationButton(destination: CounterPage2()) {
                Text("push")
            }
            PresentationButton(destination: CounterPage2()) {
                Text("present")
            }
                .environment(\.counter, CounterEnvironment(count: 2))
        }
            .environment(\.counter, CounterEnvironment(count: 1))
    }
}

#if DEBUG
struct EnvironmentPush_Previews : PreviewProvider {
    static var previews: some View {
        EnvironmentPush()
    }
}
#endif
