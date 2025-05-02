//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "magicmouse")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("My mouse")
            
            Button("Start") {
                let mouse = MyMouse()
                mouse.mouseMoveWithAction(moves: 1000000)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
