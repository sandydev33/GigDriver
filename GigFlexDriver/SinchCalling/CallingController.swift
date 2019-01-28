//
//  CallingController.swift
//  SinchAppToAppCalling
//
//  Created by khim singh on 28/11/18.
//  Copyright © 2018 eSoft. All rights reserved.
//

import UIKit
import ObjectiveC
import AVFoundation
class CallingController: SINUIViewController,SINCallDelegate,SINAudioControllerDelegate {
   var audioPlayer: AVAudioPlayer?
    var call:SINCall? = nil
    var appDelegates = (UIApplication.shared.delegate as? AppDelegate)
    @IBOutlet weak var remoteUserName: UILabel!
    @IBOutlet weak var callStateLabel: UILabel!
    @IBOutlet weak var endCallButton: UIButton!
    @IBOutlet weak var declineButton: UIButton!
    @IBOutlet weak var answerButton: UIButton!
   
//private var sin_deferredDismissalKey = 0
    var durationTimer: Timer?
//    enum EButtonsBar : Int {
//        case kButtonsAnswerDecline
//        case kButtonsHangup
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.call?.delegate = self
     
    }
    func setCall(_ call: SINCall?) {
        self.call = call
        self.call?.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        setCall(self.call)
        self.call?.delegate = self
        print((self.call?.direction.rawValue) as Any)
        print(SINCallDirection.incoming as Any)
        if (self.call?.direction.rawValue) == SINCallDirection.incoming.rawValue {
            self.callStateLabel.text = ""
            showButtons(EButtonsBar.kButtonsAnswerDecline)
            audioController()?.enableSpeaker()
            do {
                if let fileURL = Bundle.main.path(forResource: "incoming", ofType: "wav") {
                    audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
                    audioPlayer?.numberOfLoops = 50
                    audioPlayer?.play()
                } else {
                    print("No file with specified name exists")
                }
            } catch let error {
                print("Can't play the audio file failed with an error \(error.localizedDescription)")
            }
          //  audioController()?.stopPlayingSoundFile()
          //  audioController()?.startPlayingSoundFile("incoming.wav", loop: true)
        } else if (self.call?.direction.rawValue) == SINCallDirection.outgoing.rawValue {
            self.callStateLabel.text = "calling..."
            showButtons(EButtonsBar.kButtonsHangup)
         
        }
        // Do any additional setup after loading the view.
    }
    @objc func appMovedToBackground() {
        audioPlayer?.stop()
        self.audioController()?.disableSpeaker()
        self.call?.hangup()
        self.dismiss()
        print("App moved to background!")
    }
    override func viewWillAppear(_ animated: Bool) {
     
        super.viewWillAppear(true)
        self.remoteUserName.text = self.call?.remoteUserId //[self.call remoteUserId];
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      
    }
    override func viewWillDisappear(_ animated: Bool) {
     
        super.viewWillDisappear(animated)
        audioPlayer?.stop()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
     
    }
    
    func audioController() -> SINAudioController? {
        return ((UIApplication.shared.delegate as? AppDelegate)?.client)?.audioController()
    }
    @IBAction func acceptBtn(_ sender: Any) {
        audioPlayer?.stop()
      //  self.audioController()?.stopPlayingSoundFile()
        self.audioController()?.disableSpeaker()
        self.call?.answer()
    }
    @IBAction func declineBtn(_ sender: Any) {
        self.audioController()?.disableSpeaker()
        self.call?.hangup()
      self.dismiss()
    }
    @IBAction func endBtn(_ sender: Any) {
        self.call?.hangup()
        self.dismiss()
        
    }
    @objc func onDurationTimer(_ unused: Timer?) {
        
        let duration = Int(Date().timeIntervalSince((self.call?.details.establishedTime)!)) //
     self.setDuration(duration)
    }
   
    
   // pragma mark - SINCallDelegate
    func callDidProgress(_ call: SINCall!) {
        self.setCallStatusText("ringing...")
       // self.audioController()?.stopPlayingSoundFile()
       // self.audioController()?.startPlayingSoundFile(self.pathForSound("ringback.wav") as String, loop: true)
        do {
            if let fileURL = Bundle.main.path(forResource: "ringback", ofType: "wav") {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
                audioPlayer?.numberOfLoops = 50
                audioPlayer?.play()
            } else {
                print("No file with specified name exists")
            }
        } catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
       // self.audioController()?.startPlayingSoundFile("ringback.wav", loop: true)
        
    }

    func callDidEstablish(_ call: SINCall!) {
        self.startCallDurationTimer(with: #selector(self.onDurationTimer(_:)))
        self.showButtons(EButtonsBar.kButtonsHangup)
        audioPlayer?.stop()
       // self.audioController()?.stopPlayingSoundFile()
    }
    func callDidEnd(_ call: SINCall!) {
        self.dismiss()
        audioPlayer?.stop()
      //  self.audioController()?.stopPlayingSoundFile()
        self.stopCallDurationTimer()
    }
    func path(forSound soundName: String?) -> String? {
        
       
        print(URL(fileURLWithPath: Bundle.main.resourcePath ?? "").appendingPathComponent(soundName!).absoluteString)
        return URL(fileURLWithPath: Bundle.main.resourcePath ?? "").appendingPathComponent(soundName!).absoluteString
      //  return URL(fileURLWithPath: Bundle.main.resourcePath ?? "").appendingPathComponent(soundName!).absoluteString
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

   
   
    

}

