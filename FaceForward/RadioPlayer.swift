//
//  RadioPlayer.swift
//  FaceForward
//
//  Created by carmen cheng on 2017-01-06.
//
//

import Foundation
import AVFoundation
import UIKit
import MediaPlayer

class RadioPlayer: NSObject {
    
    static let sharedInstance = RadioPlayer()
    var player = AVPlayer()
    private var isPlaying = false
    let stations = RadioStations()
    let moodArray = ["Anger", "Contempt", "Happiness", "Sadness", "Disgust", "Fear", "Neutral", "Surprise"]
    
    /// chooses the radio station based on largest emotion
    func chooseStation(emotion: String) {
        let chosenStation = stations.changeStation(mood: emotion)
        
        player.currentItem?.asset.removeObserver(self, forKeyPath: "commonMetadata")
        
        player.replaceCurrentItem(with: chosenStation)
        
        player.currentItem?.asset.addObserver(self, forKeyPath: "commonMetadata", options: .new, context: nil)
        
        let title = "via FaceForward App"
        let artist = "streaming from SHOUTcast"
        
        if NSClassFromString("MPNowPlayingInfoCenter") != nil {
            
            let image:UIImage = UIImage(named: "FaceForward_Logo5")!
            let songInfo = [
                MPMediaItemPropertyTitle: title,
                MPMediaItemPropertyArtist: artist
                ] as [String : Any]
            MPNowPlayingInfoCenter.default().nowPlayingInfo = songInfo
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath != "commonMetadata" { return }
        
        var title = "via FaceForward App"
        var artist = "streaming from SHOUTcast"
        
        if let metadataList = object as? [AVMetadataItem] {
            for item in metadataList {
                print(item.commonKey ?? "nothing")
            }
        }
        if NSClassFromString("MPNowPlayingInfoCenter") != nil {
            
            let image:UIImage = UIImage(named: "FaceForward_Logo5")!
            let songInfo = [
                MPMediaItemPropertyTitle: title,
                MPMediaItemPropertyArtist: artist
                ] as [String : Any]
            MPNowPlayingInfoCenter.default().nowPlayingInfo = songInfo
        }
    }
    
    /// shuffles the radio station
    func shuffleStation() {
        let randomMood = Int(arc4random_uniform(UInt32(moodArray.count)))
        let currentStation = stations.changeStation(mood: moodArray[randomMood])
        
        player.currentItem?.asset.removeObserver(self, forKeyPath: "commonMetadata")
        
        player.replaceCurrentItem(with: currentStation)
        
        player.currentItem?.asset.addObserver(self, forKeyPath: "commonMetadata", options: .new, context: nil)
    }
    
    func play() {
        player.play()
        isPlaying = true
    }
    
    func pause() {
        player.pause()
        isPlaying = false
    }
    
    func toggle() {
        if isPlaying == true {
            pause()
        } else {
            play()
        }
    }
    
    func adjustVolume(value: Float) {
        player.volume = value
    }
    
    func currentlyPlaying() -> Bool {
        return isPlaying
    }
    
    deinit {
        player.currentItem?.asset.removeObserver(self, forKeyPath: "commonMetadata")
    }
}
