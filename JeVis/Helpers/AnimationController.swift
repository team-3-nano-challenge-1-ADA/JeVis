//
//  ViewController.swift
//  JeVis
//
//  Created by Haliza Syafa Oktaviani on 25/04/24.
//

import SwiftUI
import Lottie

//private var animationView: LottieAnimationView?
//
//override func viewDidLoad(){
//    super.viewDidLoad()
//    
//    //start animation
//    animationView = .init(name: "progressBar")
//    animationView!.frame = view.bounds
//    
//    //set animation content mode
//    animationView!.contentMode = .scaleAspectFit
//    
//    //set animation loop mode
//    animationView!.loopMode = .loop
//    
//    //adjust animation speed
//    animationView!.animationSpeed = 0.5
//    view.addSubview(animationView!)
//    
//    //play
//    animationView!.play()
//}

struct AnimationController: UIViewRepresentable {
    typealias UIViewType = UIView
    
    func makeUIView(context: Context) -> UIView {
        let animationView = LottieAnimationView(name: "progressBar")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
        return animationView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
