//
//  ViewController.swift
//  JeVis
//
//  Created by Haliza Syafa Oktaviani on 25/04/24.
//

import SwiftUI
import Lottie


struct AnimationView: UIViewRepresentable {
    typealias UIViewType = UIView
    let name:String
    
    func makeUIView(context: Context) -> UIView {
        let animationView = LottieAnimationView(name: name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
        return animationView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
