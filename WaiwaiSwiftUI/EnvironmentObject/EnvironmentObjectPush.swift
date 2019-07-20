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
    @State var showingCounter: Bool = false

    var body: some View {
        VStack {
            // どちらもクラッシュする
            NavigationLink(destination: CounterPage()) {
                Text("push(crash)")
            }
            Button("present(crash)") {
                self.showingCounter.toggle()
            }
        }
        .sheet(isPresented: $showingCounter) {
            CounterPage()
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
