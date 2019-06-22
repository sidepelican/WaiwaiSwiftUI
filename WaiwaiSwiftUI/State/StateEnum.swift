//
//  StateEnum.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/22.
//  Copyright © 2019 iceman. All rights reserved.
//

import SwiftUI

private enum MyInt {
    case zero
    case other(Int)

    init() {
        self = .zero
    }

    mutating func inc() {
        switch self {
        case .zero:
            self = .other(1)
        case let .other(v):
            self = .other(v + 1)
        }
    }

    var value: Int {
        switch self {
        case .zero:
            return 0
        case let .other(v):
            return v
        }
    }
}

//
// enumは更新検知する
//
struct StateEnum : View {
    @State private var count: MyInt = MyInt()

    var body: some View {
        VStack {
            Text("\(count.value)")
            Button(action: {
                self.count.inc()
            }) {
                Text("inc")
            }
        }
    }
}

#if DEBUG
struct StateEnum_Previews : PreviewProvider {
    static var previews: some View {
        StateEnum()
    }
}
#endif
