//
//  EnvironmentObjectPush.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/22.
//  Copyright © 2019 iceman. All rights reserved.
//

import SwiftUI

//
// EnvironmentObjectはNavigation・Presentation単位でリセットされるので注意
//
struct EnvironmentObjectPush : View {
    var body: some View {
        VStack {
            // どちらもクラッシュする
            NavigationLink(destination: CounterPage()) {
                Text("push")
            }
            PresentationLink(destination: CounterPage()) {
                Text("present")
            }
        }
            .environmentObject(CounterEnvironmentObject())
    }
}

#if DEBUG
struct EnvironmentObjectPush_Previews : PreviewProvider {
    static var previews: some View {
        EnvironmentObjectPush()
    }
}
#endif
