//
//  StateInPresentation.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/22.
//  Copyright © 2019 iceman. All rights reserved.
//

import SwiftUI

//
// Presentationから遷移した場合はcountが初期化されない
//
struct StateInPresentation : View {
    @State var showingCounter: Bool = false
    
    var body: some View {
        Button("present") {
            self.showingCounter.toggle()
        }
        .sheet(isPresented: $showingCounter) {
            StateBasic()
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
