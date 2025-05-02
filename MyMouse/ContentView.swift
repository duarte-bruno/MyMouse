import SwiftUI

struct ContentView: View {
    @State private var isMoving = false
    @State private var movement = Movement()
    
    var body: some View {
        VStack {
            Image(systemName: "magicmouse")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("My mouse")
            
            Button(isMoving ? "Stop" : "Start") {
                if isMoving {
                    movement.stopMoving()
                    isMoving = false
                } else {
                    movement.startMoving()
                    isMoving = true
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
