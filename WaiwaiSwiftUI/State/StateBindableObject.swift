//
//  StateBindableObject.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/24.
//  Copyright © 2019 iceman. All rights reserved.
//

import Combine
import SwiftUI

private class BindableInt: ObservableObject {
    @Published var value: Int

    init(_ v: Int) {
        value = v
    }
}

//
// Beta4まで: @Stateにclassをいれても更新検知はされないと思ったけどBindableObjectだったら検知される
// Beta5: 中がBindableObjectの場合でも更新検知されない、ObservableObjectでもされない
//
struct StateBindableObject : View {
    @State private var count: BindableInt = .init(0)

    var body: some View {
        VStack {
            Text("\(count.value)")
            Button(action: {
                self.count.value += 1
            }) {
                Text("inc")
            }
        }
    }
}

#if DEBUG
struct StateBindableObject_Previews : PreviewProvider {
    static var previews: some View {
        StateBindableObject()
    }
}
#endif
