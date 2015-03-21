//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Daniel Frank on 3/13/15.
//  Copyright (c) 2015 Daniel Frank. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine: AVAudioEngine!
    var reverb: AVAudioUnitReverb!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var error: NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: &error)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playAudioSlowly(sender: UIButton) {
        playAudio(0.5)
    }

    @IBAction func playAudioQuickly(sender: UIButton) {
        playAudio(1.5)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playCathedralAudio(sender: UIButton) {
        playAudioWithVariableReverb(AVAudioUnitReverbPreset.Cathedral)
    }
    
    func playAudio(rate: Float) {
        stopAndResetAll()
        audioPlayer.rate  = rate
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        stopAndResetAll()
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        playAudioWithEffect(changePitchEffect)
        
    }

    func playAudioWithVariableReverb(preset: AVAudioUnitReverbPreset){
        stopAndResetAll()
        
        var reverbEffect = AVAudioUnitReverb()
        reverbEffect.loadFactoryPreset(preset)
        reverbEffect.wetDryMix = 100
        playAudioWithEffect(reverbEffect)
    }

    //Given an effect or a time effect, set up the audioEngine with this effect connected
    func playAudioWithEffect(effect: AVAudioUnit) {
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(effect)
        
        audioEngine.connect(audioPlayerNode, to: effect, format: nil)
        audioEngine.connect(effect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        stopAndResetAll()
    }
    
    func stopAndResetAll() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0.0
    }


}
