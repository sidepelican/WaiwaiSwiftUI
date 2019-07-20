//
//  BindingInList.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/30.
//  Copyright © 2019 iceman. All rights reserved.
//

import SwiftUI

private let nums = Array(1...10)

//
//  Beta3まで: セル選択時に背景色が変化せず、一度画面を戻らないと反映されなかった。@Bindingの更新は親Viewには伝わるが自身には伝わっていなかった
//  Beta4: 更新が検知されるようになり、セル選択時に色が変化するようになった
//
private struct ListPage: View {
    @Binding var selected: Int?

    var body: some View {
        List(nums, action: { i in
            self.selected = i
        }) { i in
            Text("\(i)")
                .background(self.selected == i ? Color.red : Color.clear)
                .tag(i)
        }
    }
}

struct BindingInList : View {
    @State var selected: Int?

    var body: some View {
        VStack {
            Text("selected: \(selected.map(String.init) ?? "nil")")
            NavigationLink(destination: ListPage(selected: $selected)) {
                Text("select number")
            }
        }
    }
}

#if DEBUG
struct BindingInList_Previews : PreviewProvider {
    static var previews: some View {
        BindingInList()
    }
}
#endif
