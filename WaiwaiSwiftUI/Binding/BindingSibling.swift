//
//  BindingSibling.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/22.
//  Copyright © 2019 iceman. All rights reserved.
//

import SwiftUI

private struct IncButton: View {
    @Binding var count: Int

    var body: some View {
        Button(action: {
            self.count += 1
        }) {
            Text("inc")
        }
    }
}

private struct CounterView: View {
    @Binding var count: Int

    var body: some View {
        Text("\(count)")
    }
}

//
// 値を子ViewにBindingで渡してあげて、親がcountを使用していないとき
// countの値が変化しても親はリビルドされない
//
struct BindingSibling : View {
    @State var count = 0

    var body: some View {
        print("BindingSibling", #function)
        return VStack {
            CounterView(count: $count)
            IncButton(count: $count)
        }
    }
}

#if DEBUG
struct BindingSibling_Previews : PreviewProvider {
    static var previews: some View {
        BindingSibling()
    }
}
#endif
