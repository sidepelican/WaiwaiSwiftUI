//
//  ObjectBindingRebuild.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/22.
//  Copyright © 2019 iceman. All rights reserved.
//

import SwiftUI

//
// Beta5まで: 親がリビルドされると子の持つ@ObjectBinding(Beta5以降は@ObservedObject)は初期化されるが、更新検知対象は初期化前のBindableObjectのまま
//             → viewModelが更新されても画面が変化しない
// Beta6: 親がリビルドされたら監視される子のObservedObjectも更新されるようになった
//
struct ObjectBindingRebuild : View {
    @State var rebuildCount: Int = 0

    var body: some View {
        VStack {
            ObjectBindingBasic()
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
struct ObjectBindingRebuild_Previews : PreviewProvider {
    static var previews: some View {
        ObjectBindingRebuild()
    }
}
#endif
