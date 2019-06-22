//
//  ObjectBindingRebuildFix.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/22.
//  Copyright © 2019 iceman. All rights reserved.
//

import Combine
import SwiftUI

//
// viewModelを@Stateとして保持することでNavigation単位で生存させ、onReceiveで更新を受け取る
//
private struct ObjectBindingBasicFix : View {
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

//
// こちらの実装は変わらず。
//
struct ObjectBindingRebuildFix : View {
    @State var rebuildCount: Int = 0

    var body: some View {
        VStack {
            ObjectBindingBasicFix()
                .padding(8)
                .border(Color.green)
            Button(action: {
                self.rebuildCount += 1
            }) {
                Text("rebuild: \(rebuildCount)")
            }
        }
    }
}

#if DEBUG
struct ObjectBindingRebuildFix_Previews : PreviewProvider {
    static var previews: some View {
        ObjectBindingRebuildFix()
    }
}
#endif
