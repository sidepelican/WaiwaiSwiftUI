//
//  StateBasic.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/22.
//  Copyright © 2019 iceman. All rights reserved.
//

import SwiftUI

//
// 一度RootViewに戻って再びこの画面を訪れるとcountは0に戻る
//
struct StateBasic : View {
    @State var count: Int = 0
    
    var body: some View {
        VStack {
            Text("\(count)")
            Button(action: {
                self.count += 1
            }) {
                Text("inc")
            }
        }
    }
}

#if DEBUG
struct StateBasic_Previews : PreviewProvider {
    static var previews: some View {
        StateBasic()
    }
}
#endif
