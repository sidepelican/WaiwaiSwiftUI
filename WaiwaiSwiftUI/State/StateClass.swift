//
//  StateClass.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/22.
//  Copyright © 2019 iceman. All rights reserved.
//

import SwiftUI

private class MyInt {
    var value: Int {
        didSet {
            print(value)
        }
    }
    init(_ v: Int) {
        value = v
    }
}

//
// @Stateにclassをいれても更新検知はされない
//
struct StateClass : View {
    @State private var count: MyInt = MyInt(0)

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
struct StateClass_Previews : PreviewProvider {
    static var previews: some View {
        StateClass()
    }
}
#endif
