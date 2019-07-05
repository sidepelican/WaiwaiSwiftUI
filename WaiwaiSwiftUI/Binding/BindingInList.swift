//
//  BindingInList.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/30.
//  Copyright © 2019 iceman. All rights reserved.
//

import SwiftUI

private let nums = Array(1...10)

private struct ListPage: View {
    @Binding var selected: Int?

    var body: some View {
        List(nums.identified(by: \.self), selection: $selected, action: { i in
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
