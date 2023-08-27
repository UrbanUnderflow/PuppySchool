//
//  BackgroundVideoView.swift
//  PuppySchool
//
//  Created by Tremaine Grant on 8/27/23.
//

import SwiftUI
import AVKit
import Foundation
import AVFoundation

struct BackgroundVideoView: View {
    let videoURLString: String
    var isMuted: Bool = true
    @State private var player: AVPlayer? = AVPlayer()
    @State private var playerLooper: AVPlayerLooper? = nil
    
    init(videoURLString: String, isMuted: Bool, player: AVPlayer? = nil, playerLooper: AVPlayerLooper? = nil) {
        self.videoURLString = videoURLString
        self.isMuted = isMuted
        self.player = player
        self.playerLooper = playerLooper
    }

    var body: some View {
        GeometryReader { geometry in
            VideoPlayer(player: player)
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .onAppear {
                    guard let url = URL(string: videoURLString) else {
                        print("Invalid URL: \(videoURLString)")
                        return
                    }
                    let asset = AVAsset(url: url)
                    let playerItem = AVPlayerItem(asset: asset)
                    
                    self.player = AVQueuePlayer(playerItem: playerItem)
                    self.player?.isMuted = isMuted
                    
                    self.playerLooper = AVPlayerLooper(player: self.player as! AVQueuePlayer, templateItem: playerItem)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.player?.play()
                    }
                }
                .onDisappear {
                    self.player?.pause()
                    self.player = nil
                    self.playerLooper?.disableLooping()
                    self.playerLooper = nil
                }
                .edgesIgnoringSafeArea(.all)
        }
    }
}


