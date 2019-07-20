//
//  StateUnusedFix.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/22.
//  Copyright © 2019 iceman. All rights reserved.
//

import SwiftUI
import Combine

private class AccountManager: BindableObject {
    let willChange = PassthroughSubject<AccountManager, Never>()
    static let shared = AccountManager()
    var isPurchased: Bool = false {
        willSet {
            willChange.send(self)
        }
    }
}

//
// 何らかの方法でViewに更新が検知できるようにしてあげる必要がある
//
struct StateUnusedFix : View {
    @ObjectBinding private var accountManager: AccountManager = .shared
    @State var okane: Int = 0

    var body: some View {
        VStack {
            if accountManager.isPurchased {
                Text("\(okane)")
            } else {
                Text("not purchased")
            }
            Button(action: {
                self.accountManager.isPurchased = true
                self.okane += 1
                print("current okane:", self.okane)
            }) {
                Text("purchase")
            }
        }
    }
}

#if DEBUG
struct StateUnusedFix_Previews : PreviewProvider {
    static var previews: some View {
        StateUnusedFix()
    }
}
#endif
