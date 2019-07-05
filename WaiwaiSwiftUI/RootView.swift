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
                    NavigationLink(destination: StateBasic()) {
                        Text("StateBasic")
                    }
                    NavigationLink(destination: StateInPresentation()) {
                        Text("StateInPresentation")
                    }
                    NavigationLink(destination: StateUnused()) {
                        Text("StateUnused")
                    }
                    NavigationLink(destination: StateUnusedFix()) {
                        Text("StateUnusedFix")
                    }
                    NavigationLink(destination: StateClass()) {
                        Text("StateClass")
                    }
                    NavigationLink(destination: StateEnum()) {
                        Text("StateEnum")
                    }
                    NavigationLink(destination: StateBindableObject()) {
                        Text("StateBindableObject")
                    }
                    NavigationLink(destination: BindingBasic()) {
                        Text("BindingBasic")
                    }
                    NavigationLink(destination: BindingSibling()) {
                        Text("BindingSibling")
                    }
                    NavigationLink(destination: BindingInList()) {
                        Text("BindingInList")
                    }
                }
                Section {
                    NavigationLink(destination: ObjectBindingBasic()) {
                        Text("ObjectBindingBasic")
                    }
                    NavigationLink(destination: ObjectBindingRebuild()) {
                        Text("ObjectBindingRebuild")
                    }
                    NavigationLink(destination: ObjectBindingRebuildFix()) {
                        Text("ObjectBindingRebuildFix")
                    }
                    NavigationLink(destination: EnvironmentObjectBasic()) {
                        Text("EnvironmentObjectBasic")
                    }
                    NavigationLink(destination: EnvironmentObjectPush()) {
                        Text("EnvironmentObjectPush")
                    }
                    NavigationLink(destination: EnvironmentBasic()) {
                        Text("EnvironmentBasic")
                    }
                    NavigationLink(destination: EnvironmentPush()) {
                        Text("EnvironmentPush")
                    }
                    NavigationLink(destination: LifeTimeCheck()) {
                        Text("LifeTimeCheck")
                    }
                    // ↓ 何故かこれは初回しか開けない
                    PresentationLink(destination: Text("Hello")) {
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
