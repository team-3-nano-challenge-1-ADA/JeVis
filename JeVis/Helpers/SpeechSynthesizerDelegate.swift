//
//  SpeechSynthesizerDelegate.swift
//  JeVis
//
//  Created by Jovanna Melissa on 29/04/24.
//

import Foundation
import AVFoundation

class SpeechSynthesizerDelegate: NSObject, AVSpeechSynthesizerDelegate{
    var didFinishSuccess = false
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
            // When speech finishes, perform some tasks
            print("Speech synthesis finished for utterance: \(utterance.speechString)")
            didFinishSuccess = true
            print(didFinishSuccess)
        }
}
