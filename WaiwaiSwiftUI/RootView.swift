//
//  RootView.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/22.
//  Copyright © 2019 iceman. All rights reserved.
//

import SwiftUI

struct RootView : View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationButton(destination: StateBasic()) {
                        Text("StateBasic")
                    }
                    NavigationButton(destination: StateInPresentation()) {
                        Text("StateInPresentation")
                    }
                    NavigationButton(destination: StateUnused()) {
                        Text("StateUnused")
                    }
                    NavigationButton(destination: StateUnusedFix()) {
                        Text("StateUnusedFix")
                    }
                    NavigationButton(destination: StateClass()) {
                        Text("StateClass")
                    }
                    NavigationButton(destination: StateEnum()) {
                        Text("StateEnum")
                    }
                    NavigationButton(destination: StateBindableObject()) {
                        Text("StateBindableObject")
                    }
                    NavigationButton(destination: BindingBasic()) {
                        Text("BindingBasic")
                    }
                    NavigationButton(destination: BindingSibling()) {
                        Text("BindingSibling")
                    }
                    NavigationButton(destination: ObjectBindingBasic()) {
                        Text("ObjectBindingBasic")
                    }
                }
                Section {
                    NavigationButton(destination: ObjectBindingRebuild()) {
                        Text("ObjectBindingRebuild")
                    }
                    NavigationButton(destination: ObjectBindingRebuildFix()) {
                        Text("ObjectBindingRebuildFix")
                    }
                    NavigationButton(destination: EnvironmentObjectBasic()) {
                        Text("EnvironmentObjectBasic")
                    }
                    NavigationButton(destination: EnvironmentObjectPush()) {
                        Text("EnvironmentObjectPush")
                    }
                    NavigationButton(destination: EnvironmentBasic()) {
                        Text("EnvironmentBasic")
                    }
                    NavigationButton(destination: EnvironmentPush()) {
                        Text("EnvironmentPush")
                    }
                    NavigationButton(destination: LifeTimeCheck()) {
                        Text("LifeTimeCheck")
                    }
                    // ↓ 何故かこれは初回しか開けない
                    PresentationButton(destination: Text("Hello")) {
                        Text("PresentationFromRootView")
                    }
                }
            }
                .font(.headline)
                .navigationBarTitle(Text("Sample"))
        }
    }
}

#if DEBUG
struct RootView_Previews : PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
#endif
