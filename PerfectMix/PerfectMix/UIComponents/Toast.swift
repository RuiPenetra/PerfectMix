//
//  Toast.swift
//  PerfectMix
//
//  Created by Rui Jorge on 12/12/2024.
//

import SwiftUI

struct Toast: View {
    let message: String
    let backgroundColor: Color
    
    var body: some View {
        HStack{
            Image(systemName: "checkmark.circle")
                .foregroundColor(Color.green)
            Text(message)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .cornerRadius(10)
        }
        .padding()
        .background(Capsule().fill(Color.white))
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 4)  // Adding shadow
        .frame(maxWidth: UIScreen.main.bounds.width * 0.8)


    }
}

struct Toast_Previews: PreviewProvider {
    static var previews: some View {
        Toast(message: "Test", backgroundColor: Color.gray.opacity(0.6))
            .previewLayout(.sizeThatFits)
            .environmentObject(RecipeViewModel())
    }
}


