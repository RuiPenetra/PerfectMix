import SwiftUI

extension View {
    func toast(
        isPresented: Binding<Bool>,
        message: String,
        backgroundColor: Color = .black,
        duration: TimeInterval = 0.4
    ) -> some View {
        ZStack(alignment: .top) {
            self
            if isPresented.wrappedValue {
                Toast(message: message, backgroundColor: backgroundColor)
                    .transition(.move(edge: .top))
                    .zIndex(1)  // Ensures the toast is on top
                    .padding(.top, 40)  // Padding from the top of the screen
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                            withAnimation{
                                isPresented.wrappedValue = false
                            }
                        }
                    }
                    .animation(.easeInOut, value: isPresented.wrappedValue) 
            }
        }
    }
}
