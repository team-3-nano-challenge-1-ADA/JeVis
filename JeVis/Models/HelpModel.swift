//
//  HelpModel.swift
//  JeVis
//
//  Created by Jovanna Melissa on 26/04/24.
//

import Foundation

@Observable class HelpModel{
    var tabIndex = 0
    
    var onboardings: [Onboarding] = [
        (Onboarding(screenshot: "upload page", showButton: false)),
        (Onboarding(screenshot: "result", showButton: true))
    ]
}
