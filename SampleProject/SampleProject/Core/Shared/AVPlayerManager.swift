//
//  AVPlayerManager.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import AVKit
import AVFoundation
import CoreMedia
import MediaPlayer


struct PlayerKeys {
    static let PlaybackBufferEmpty = "playbackBufferEmpty"
    static let PlaybackLikelyToKeepUp = "playbackLikelyToKeepUp"
}


protocol PlayerDurationDalegate {
    func getVideoTime(currentTime: Double, totalTime: Double)
    func updateView()
}


final class AVPlayerManager: NSObject {
    
    //MARK: - Variables
    var delegate : PlayerDurationDalegate?
    static let sharedInstance = AVPlayerManager()
    var downloadDataSource: [[String: Any]]?
    var playingIndex = -1
    var isRepeat = false
    var isDownload = false
    var player: AVPlayer?
    var playerLayer = AVPlayerLayer()
    
    
    //MARK: - Init Methods
    override init() {
        super.init()
        setupAudioSession()
        setupRemoteControls()
    }
    
    
    //----------------------------------------------------------------------------------------------------
    //MARK: - Setup Methods
    fileprivate func setupAudioSession(){
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default, options: .defaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("error audio session")
        }
    }
    
    fileprivate func setupRemoteControls(){
        UIApplication.shared.becomeFirstResponder()
        UIApplication.shared.beginReceivingRemoteControlEvents()
    }
    
    
    //----------------------------------------------------------------------------------------------------
    //MARK: - Player Methods
    fileprivate func playAVwith(stringURL: String) -> AVPlayerLayer {
        if stringURL.isEmpty {
            return AVPlayerLayer()
        } else {
            let avURL = URL(string: stringURL)
            player = AVPlayer(url: avURL!)
            player?.allowsExternalPlayback = true
            player?.usesExternalPlaybackWhileExternalScreenIsActive = true
            player?.automaticallyWaitsToMinimizeStalling = false
            playerLayer.player = player
            playerLayer.videoGravity = .resizeAspect
            player?.play()
            playStream()
            addObserver()
            
            return playerLayer
        }
    }
    
    func getPlayingAVDataWith(stringURL: String) -> AVPlayerLayer {
        if isPlayerEmpty() {
            return playAVwith(stringURL: stringURL)
        } else {
            return playerLayer
        }
    }
    
    
    
    //----------------------------------------------------------------------------------------------------
    //MARK: - Player Handler Methods
    func isPlaying()->Bool{
        if(player?.rate == nil){
            return false
        }
        if let _ = player{
            if((player?.rate ?? 0.0) >  0.0) {
                return true
            }
        }
        return false
    }
    
    func isPlayerEmpty() -> Bool {
        if player == nil {
            return true
        } else {
            return false
        }
    }
    
    func setPlayerToNil() {
        if !isPlayerEmpty() {
            player?.pause()
            player = nil
        }
    }
    
    
    func checkPlayPause() -> UIImage {
        if player?.rate == 0.0 {
            player?.play()
            return #imageLiteral(resourceName: "Pause")
        } else {
            player?.pause()
            return #imageLiteral(resourceName: "Play")
        }
    }
    
    func seekPlayerTo(time: Double) {
        player?.seek(to: CMTime(seconds: time, preferredTimescale: 1))
    }
    
    func setView(view: UIView) {
        playerLayer.frame = CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: view.bounds.height)
    }
    
    fileprivate func addObserver() {
        player?.currentItem?.addObserver(self, forKeyPath: PlayerKeys.PlaybackBufferEmpty , options: .new, context: nil)
        player?.currentItem?.addObserver(self, forKeyPath: PlayerKeys.PlaybackLikelyToKeepUp, options: .new, context: nil)
    }
    
}


//----------------------------------------------------------------------------------------------------
//MARK: - Player While Playing
extension AVPlayerManager {
    
    func playStream() {
        if !isPlayerEmpty() {
            player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
                if self.isPlayerEmpty() {
                    return
                } else {
                    if self.player?.currentItem?.status == .readyToPlay {
                        self.songReadyToPlay()
                        
                    } else if self.player?.currentItem?.status == .unknown {
                        print("👽👽👽👽👽👽👽👽👽👽")
                    }
                }
            }
        }
    }
    
    
    fileprivate func songReadyToPlay() {
        let currentTime : Float64 = CMTimeGetSeconds((self.player?.currentTime())!)
        let totalDuration : Float64 = CMTimeGetSeconds((self.player?.currentItem!.asset.duration)!)
        self.delegate?.getVideoTime(currentTime: currentTime, totalTime: totalDuration)
        
        if Int(currentTime) == Int(totalDuration) {
            print("🔚🔚🔚🔚🔚🔚🔚🔚🔚🔚")
            return
        }
        
        playerHandling()
    }
    
    
    fileprivate func playerHandling() {
        if self.player?.currentItem!.isPlaybackLikelyToKeepUp ?? false {
            print("🎶🎶🎶🎶🎶🎶🎶🎶🎶🎶")
            
        } else if self.player?.currentItem!.isPlaybackBufferEmpty ?? false {
            print("⌛️⌛️⌛️⌛️⌛️⌛️⌛️⌛️⌛️⌛️")
            
        }  else if self.player?.currentItem!.isPlaybackBufferFull ?? false {
            print("💽💽💽💽💽💽💽💽💽💽")
            
        } else {
            print("🗑🗑🗑🗑🗑🗑🗑🗑🗑🗑")
        }
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if object is AVPlayerItem {
            switch keyPath {
            case PlayerKeys.PlaybackBufferEmpty:
                print("🔇🔇🔇🔇🔇🔇🔇🔇🔇🔇")
                break
                
            case PlayerKeys.PlaybackLikelyToKeepUp:
                print("🔊🔊🔊🔊🔊🔊🔊🔊🔊🔊")
                
                let mpic = MPNowPlayingInfoCenter.default()
                let totalDuration : Float64 = CMTimeGetSeconds(player?.currentItem!.asset.duration ?? CMTime(seconds: 0.0, preferredTimescale: .max))
                
                let urlString = "https://img7.androidappsapk.co/300/b/1/a/com.ludicside.mrsquare.png"
                let url = URL(string: urlString)!
                if let data = try? Data.init(contentsOf: url), let image = UIImage(data: data) {
                    
                    let artwork = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { (_ size : CGSize) -> UIImage in
                        return image
                    })
                    
                    DispatchQueue.main.async {
                        mpic.nowPlayingInfo = [
                            MPMediaItemPropertyTitle: "Title Of Song",
                            MPMediaItemPropertyPlaybackDuration: NSNumber(floatLiteral: totalDuration),
                            MPMediaItemPropertyArtwork: artwork,
                            MPMediaItemPropertyArtist: "Artist Name" ,
                            MPMediaItemPropertyAlbumTitle: "Album Name",
                            MPNowPlayingInfoPropertyPlaybackRate:1.0
                        ]}
                }
                
                
                break
                
            case .none:
                print("📵📵📵📵📵📵📵📵📵📵")
                break
                
            case .some(_):
                print("♻️♻️♻️♻️♻️♻️♻️♻️♻️♻️")
                break
            }
        }
    }
}
