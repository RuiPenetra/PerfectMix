//
//  InfoCard.swift
//  PerfectMix
//
//  Created by Rui Jorge on 02/12/2024.
//

import SwiftUI

import SwiftUI

struct InfoCard: View {
    let title: String
    let image: String
    let value: String

    var body: some View {
        VStack {

            VStack {
                Image(systemName: image)
                    .font(.system(size: 20))
                    .foregroundColor(Color.accentColor)
                
                Text(value)
                    .font(.system(size: 15))
                    .padding()
            }
        }
    }
}


struct InfoCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InfoCard(title: "Portion", image: "person.2", value: "2")
                .previewLayout(.sizeThatFits)
                .padding()
                .background(Color.gray.opacity(0.2))

            InfoCard(title: "Difficulty", image: "chart.bar", value: "Easy")
                .previewLayout(.sizeThatFits)
                .padding()
                .background(Color.gray.opacity(0.2))

            InfoCard(title: "Time", image: "timer", value: "15 min")
                .previewLayout(.sizeThatFits)
                .padding()
                .background(Color.gray.opacity(0.2))
        }
    }
}
