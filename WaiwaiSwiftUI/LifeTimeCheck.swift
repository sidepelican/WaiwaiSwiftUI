//
//  LifeTimeCheck.swift
//  WaiwaiSwiftUI
//
//  Created by kenta on 2019/06/25.
//  Copyright © 2019 iceman. All rights reserved.
//

import Combine
import SwiftUI

struct ValueModel {
    var count: Int = 0
}

class ClassModel {
    var count: Int = 0
}

class BindableModel: ObservableObject {
    @Published var count: Int = 0
}

struct ValueStateView: View {
    @State var valueState: ValueModel = .init()

    var body: some View {
        HStack {
            Text("valueInState: \(valueState.count)")
            Spacer()
            Button(action: {
                self.valueState.count += 1
            }) { Text("inc") }
        }
    }
}

struct ClassStateView: View {
    @State var classState: ClassModel = .init()

    var body: some View {
        HStack {
            Text("classInState: \(classState.count)")
            Spacer()
            Button(action: {
                self.classState.count += 1
            }) { Text("inc") }
        }
    }
}

struct BindableStateView: View {
    @State var bindableState: BindableModel = .init()

    var body: some View {
        HStack {
            Text("bindableInState: \(bindableState.count)")
            Spacer()
            Button(action: {
                self.bindableState.count += 1
            }) { Text("inc") }
        }
    }
}

struct BindableObjectBindingView: View {
    @ObservedObject var bindableObjectBinding: BindableModel = .init()

    var body: some View {
        HStack {
            Text("bindableInObjectBinding: \(bindableObjectBinding.count)")
            Spacer()
            Button(action: {
                self.bindableObjectBinding.count += 1
            }) { Text("inc") }
        }
    }
}

struct LifeTimeDetailView: View {
    @State var rand: Int = 0
    var body: some View {
        VStack {
            ValueStateView()
            ClassStateView()
            BindableStateView()
            BindableObjectBindingView()
            Button(action: { self.rand += 1 }) { Text("refresh\(self.rand)") }
        }
            .padding()
    }
}

struct LifeTimeCheck : View {
    @State var showingCounter: Bool = false

    var body: some View {
        VStack {
            LifeTimeDetailView()
            NavigationLink(destination: LifeTimeDetailView()) {
                Text("navigation")
            }
            Button("presentation") {
                self.showingCounter.toggle()
            }
            .sheet(isPresented: $showingCounter) {
                LifeTimeDetailView()
            }
        }
    }
}

#if DEBUG
struct LifeTimeCheck_Previews : PreviewProvider {
    static var previews: some View {
        LifeTimeCheck()
    }
}
#endif
