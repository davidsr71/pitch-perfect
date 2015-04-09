//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by David Hughes on 3/04/2015.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        // Do any additional setup after loading the view.
        //if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
        //{
       //     var filePathURL = NSURL.fileURLWithPath(filePath)
      //      audioPlayer = AVAudioPlayer(contentsOfURL: filePathURL, error: nil)
      //          audioPlayer.enableRate = true      }
      //  else
      //  {
      //      println("The filePath is empty")
      //  }
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true      
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBOutlet weak var playSound:UIButton!
    
    @IBOutlet weak var playFastButton: UIButton!
    
    @IBOutlet weak var stoplayButton: UIButton!
    
    @IBAction func playSoundAction(sender: UIButton) {
        

            audioPlayer.rate = 0.5
        
              audioPlayer.play()
         }
    
    @IBAction func playFastAction(sender: UIButton) {
        
        audioPlayer.rate = 2.0
        
        audioPlayer.play()
        
        
    }
    
    @IBAction func stopPlayAction(sender: UIButton) {
        
        audioPlayer.stop()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
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
    
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
               playAudioWithVariablePitch(-1000)    }
}
