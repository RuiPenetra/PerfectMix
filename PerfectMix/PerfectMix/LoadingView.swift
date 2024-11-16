//
//  LoadingView.swift
//  PerfectMix
//
//  Created by Rui Jorge on 15/11/2024.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicateView = UIActivityIndicatorView(style: .large)
        activityIndicateView.color = UIColor.orange
        activityIndicateView.startAnimating()
        return activityIndicateView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
    
}

struct LoadingView: View {
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            ActivityIndicator()
        }
    }
}
