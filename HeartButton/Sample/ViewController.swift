//
//  ViewController.swift
//  Sample
//
//  Created by yuki.kuroda on 2018/05/11.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit
import HeartButton

class ViewController: UIViewController {

    @IBOutlet weak var heartButton: HeartButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.heartButton.stateChanged = { sender, isOn in
            if isOn {
                print("change state: is on")
            } else {
                print("change state: is off")
            }
        }
    }

    @IBAction func didTapChangeStateWithAnimationButton(_ sender: Any) {
        self.heartButton.changeState(isOn: !self.heartButton.isOn, animated: true)
    }
    
    @IBAction func didTapChangeStateButton(_ sender: Any) {
        self.heartButton.changeState(isOn: !self.heartButton.isOn, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

