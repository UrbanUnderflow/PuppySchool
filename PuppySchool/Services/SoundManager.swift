//
//  SoundManager.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/26/23.
//

import Foundation
import AVFoundation

class SoundManager {

    static let sharedInstance = SoundManager()

    private var audioPlayer: AVAudioPlayer?

    private init() {}

    func playClicker() {
        guard let url = Bundle.main.url(forResource: "ClickerSound", withExtension: "m4a") else { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func playClapping() {
        guard let url = Bundle.main.url(forResource: "cheering", withExtension: "mp3") else { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func playCheering() {
        guard let url = Bundle.main.url(forResource: "cheer", withExtension: "mp3") else { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }

}
