//
//  PlaySoundsViewController.swift
//  Pitch Perfect2
//
//  Created by Dori Frost on 3/6/15.
//  Copyright (c) 2015 Dori.Frost. All rights reserved.
//

import UIKit
import AVFoundation
class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error:nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error:nil)
        
 
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playSlow(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }

    
    @IBAction func playFast(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = 1.5
        audioPlayer.play()
    }
    
    @IBAction func stopPlay(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func playReverb(sender: UIButton) {
        var reverbEffect = AVAudioUnitReverbPreset.Cathedral
        playAudioWithReverbEffect(reverbEffect, wdMix: 100)
        
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
       
    }
    
    @IBAction func playDarthAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
        
    }
    
    //New Function
    func playAudioWithReverbEffect(preset: AVAudioUnitReverbPreset, wdMix: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changeReverbEffect = AVAudioUnitReverb()
        changeReverbEffect.loadFactoryPreset(preset)
        changeReverbEffect.wetDryMix = wdMix
        audioEngine.attachNode(changeReverbEffect)
        
        audioEngine.connect(audioPlayerNode, to: changeReverbEffect, format: nil)
        audioEngine.connect(changeReverbEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    //New Function
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }

    
    
}


