//
//  SettingsView.swift
//  NewsMoleRat
//
//  Created by Kiacz Gabor on 2023. 09. 13..
//

import SwiftUI

struct Foo {
    var name: String
}

class Bar {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    deinit {
        print("bar deinit")
    }
}

struct SettingsView: View {
    @State var foo: Foo = Foo(name: "Foo gizmo")
    let bar: Bar = Bar(name: "Bar gadget")

    func modifyFoo(fooParam: inout Foo ) {
        fooParam.name = "modified foo 🐶"
    }
    
    func modifyBar(barParam: Bar) {
        barParam.name = "modified bar 🐎"
    }
    
    func doSomething() {
        

        print("init foo: \(foo.name)")
        print("init bar: \(bar.name)")
        
        foo.name = "🍩"
        print("foo: \(foo.name)")
        
        modifyFoo(fooParam: &foo)
        print("foo: \(foo.name)")

        bar.name = "🍓"
        print("bar:\(bar.name)")
        modifyBar(barParam: bar)
        print("bar:\(bar.name)")
    }
    
    init() {
        //doSomething()
        
    }
    
    var body: some View {
        VStack{
//            TextField("Search...", text: $config.allat)
            Text("Hello, World!")
            Button("do something") {
                self.doSomething()
            }
//            Form {
//                TextField(text: $config.allat, prompt: Text("Required")) {
//                    Text("Username")
//                }
//                SecureField(text: $config.allat, prompt: Text("Required")) {
//                    Text("Password")
//                }
            }
            Spacer()

        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
