//
//  ObjectBindingBasic.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/22.
//  Copyright © 2019 iceman. All rights reserved.
//

import Combine
import SwiftUI

class CountViewModel: BindableObject {
    let willChange = PassthroughSubject<CountViewModel, Never>()
    var count: Int = 0

    private let uuid = UUID()
    init() {
        print(#function, uuid)
    }
    deinit {
        print(#function, uuid)
    }

    func inc() {
        willChange.send(self)
        count += 1
    }
}

//
// @ObjectBindingを利用するとclassオブジェクトの更新も検知できるようになる
//
struct ObjectBindingBasic : View {
    @ObjectBinding var viewModel = CountViewModel()

    var body: some View {
        VStack {
            Text("\(viewModel.count)")
            Button(action: {
                self.viewModel.inc()
            }) { Text("inc") }
        }
    }
}

#if DEBUG
struct ObjectBindingBasic_Previews : PreviewProvider {
    static var previews: some View {
        ObjectBindingBasic()
    }
}
#endif
