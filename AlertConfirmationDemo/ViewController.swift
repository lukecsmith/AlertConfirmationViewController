//
//  ViewController.swift
//  AlertConfirmationDemo
//
//  Created by Luke Smith on 01/08/2018.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var alertConfirmVC: AlertConfirmationViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func triggerAlertClicked(_ sender: Any) {
        self.alertConfirmVC = AlertConfirmationViewController(nibName: "AlertConfirmationViewController", bundle: nil)
        self.alertConfirmVC.modalPresentationStyle = .overCurrentContext //ensures clear background possible
        let title = NSLocalizedString("Do Action?", comment: "")
        let message = NSLocalizedString("Are you sure you want to do this particular thing?", comment: "")
        let ok = NSLocalizedString("OK", comment: "")
        let cancel = NSLocalizedString("Cancel", comment: "")
        let failedTitle = NSLocalizedString("Task Failed", comment: "")
        let failedMessage = NSLocalizedString("We were unable to complete this task", comment: "")
        self.present(self.alertConfirmVC, animated: false, completion: {
            self.alertConfirmVC.setupWith(title: title, message: message, button1Title: ok, button2Title: cancel, button3Title: nil, failureTitle: failedTitle, failureMessage: failedMessage, delegate: self)
        })
    }
}

extension ViewController: AlertConfirmationDelegate {
    func button1Clicked() {
        //ok clicked
        //set it to spinning
        self.alertConfirmVC.mode = .spinning
        //after a delay for some kind of task happening, set it to success
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2), execute: {
            self.alertConfirmVC.mode = .success
            //after another delay, remove the AlertConfirmVC
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2), execute: {
                self.alertConfirmVC.dismiss(animated: true, completion: nil)
            })
        })
    }
    func button2Clicked() {
        //cancel clicked
        self.alertConfirmVC.dismiss(animated: true, completion: nil)
    }
    func button3Clicked() {
        //unused
    }
}

