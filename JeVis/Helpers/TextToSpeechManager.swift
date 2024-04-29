//
//  TextToSpeechManager.swift
//  JeVis
//
//  Created by Rizki Maulana on 25/04/24.
//

import AVFoundation

class TextToSpeechManager {
    let synthesizer = AVSpeechSynthesizer()
    let delegate = SpeechSynthesizerDelegate()
    
    func speak(_ text: String) {
        synthesizer.delegate = delegate
        let speechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "id-ID")
        speechUtterance.pitchMultiplier = 0.4
        
        synthesizer.speak(speechUtterance)
    }
}
