//
//  StateUnused.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/22.
//  Copyright © 2019 iceman. All rights reserved.
//

import SwiftUI

private class AccountManager {
    static let shared = AccountManager()
    var isPurchased: Bool = false
}

//
// Beta3まで: 初回のbody呼び出し時に使用されなかったStateに更新があってもViewは更新されない
// Beta4: 初回のbody呼び出し時に使用されたか関係なく、Stateに更新があったらViewが更新される
//
struct StateUnused : View {
    @State var okane: Int = 0

    var body: some View {
        VStack {
            if AccountManager.shared.isPurchased {
                Text("\(okane)")
            } else {
                Text("not purchased")
            }
            Button(action: {
                AccountManager.shared.isPurchased = true
                self.okane += 1
                print("current okane:", self.okane)
            }) {
                Text("purchase")
            }
        }
    }
}

#if DEBUG
struct StateUnused_Previews : PreviewProvider {
    static var previews: some View {
        StateUnused()
    }
}
#endif
