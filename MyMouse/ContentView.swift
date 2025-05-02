//

import SwiftUI

struct ContentView: View {
    @State private var isMoving = false
    @State private var mouse = MyMouse()
    
    var body: some View {
        VStack {
            Image(systemName: "magicmouse")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("My mouse")
            
            Button(isMoving ? "Stop" : "Start") {
                if isMoving {
                    mouse.stop()
                    isMoving = false
                } else {
                    isMoving = true
                    DispatchQueue.global(qos: .userInitiated).async {
                        mouse.mouseMoveWithAction(moves: 1000000)
                        DispatchQueue.main.async { isMoving = false }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
