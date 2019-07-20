//
//  StateBindableObject.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/24.
//  Copyright © 2019 iceman. All rights reserved.
//

import Combine
import SwiftUI

private class BindableInt: BindableObject {
    let willChange = PassthroughSubject<BindableInt, Never>()

    var value: Int {
        willSet {
            willChange.send(self)
        }
    }
    init(_ v: Int) {
        value = v
    }
}

//
// @Stateにclassをいれても更新検知はされないと思ったけどBindableObjectだったら検知される
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
