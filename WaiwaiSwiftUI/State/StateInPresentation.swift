//
//  StateInPresentation.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/22.
//  Copyright © 2019 iceman. All rights reserved.
//

import SwiftUI

//
// PresentationButtonから遷移した場合はcountが初期化されない
//
struct StateInPresentation : View {
    var body: some View {
        PresentationButton(destination: StateBasic()) {
            Text("present")
        }
    }
}

#if DEBUG
struct StateInPresentation_Previews : PreviewProvider {
    static var previews: some View {
        StateInPresentation()
    }
}
#endif
