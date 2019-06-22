//
//  BindingBasic.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/22.
//  Copyright © 2019 iceman. All rights reserved.
//

import SwiftUI

//
// countの参照を受け取って値を変化させる。自身はcountの実体をもたない
//
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

//
// countをBinding<Int>として子Viewに渡して入力を受け取る
//
struct BindingBasic : View {
    @State var count = 0

    var body: some View {
        VStack {
            Text("\(count)")
            IncButton(count: $count)
        }
    }
}

#if DEBUG
struct BindingBasic_Previews : PreviewProvider {
    static var previews: some View {
        BindingBasic()
    }
}
#endif
