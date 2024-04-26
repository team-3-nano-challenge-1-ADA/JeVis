//
//  SampleModel.swift
//  JeVis
//
//  Created by Rizki Maulana on 26/04/24.
//

import Foundation

struct SampleModel {
    let name: String
    let type: String
    let distance: Double
    let weight: Double
    let gender: String
    
    static func generateLeppyData() -> SampleModel {
        let pet = SampleModel(name: "Leppy", type: "Domestic", distance: 1.0, weight: 3.0, gender: "Male")
        return pet
    }
    
    static func generateButetData() -> SampleModel {
        let pet = SampleModel(name: "Butet", type: "Persian", distance: 3.5, weight: 5.0, gender: "Female")
        return pet
    }
    
    static func generateSkyData() -> SampleModel {
        let pet = SampleModel(name: "Sky", type: "Domestic", distance: 8.5, weight: 4.9, gender: "Female")
        return pet
    }
    
    static func generateKentangData() -> SampleModel {
        let pet = SampleModel(name: "Kentang", type: "British Shorthair", distance: 8.5, weight: 4.2, gender: "Female")
        return pet
    }
}

