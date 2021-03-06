//
//  ViewController.swift
//  AlertConfirmationDemo
//
//  Created by Luke Smith on 01/08/2018.
//  Copyright © 2018 Luke Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    weak var alertConfirmVC: AlertConfirmationViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func triggerAlertClicked(_ sender: Any) {
        let alertConfirmVC = AlertConfirmationViewController(nibName: "AlertConfirmationViewController", bundle: nil)
        alertConfirmVC.modalPresentationStyle = .overCurrentContext //ensures clear background possible
        alertConfirmVC.titleText = NSLocalizedString("Do Action?", comment: "")
        alertConfirmVC.messageText = NSLocalizedString("Are you sure you want to do this particular thing?", comment: "")
        alertConfirmVC.btn0Text = NSLocalizedString("OK", comment: "")
        alertConfirmVC.btn1Text = NSLocalizedString("Cancel", comment: "")
        alertConfirmVC.failedTitleText = NSLocalizedString("Task Failed", comment: "")
        alertConfirmVC.failedMessageText = NSLocalizedString("We were unable to complete this task", comment: "")
        alertConfirmVC.delegate = self
        self.present(alertConfirmVC, animated: false, completion: nil)
        self.alertConfirmVC = alertConfirmVC
    }
    func okAction() {
        //action to be executed if ok is clicked.  for this example, just a pause before setting dialogue to 'success'
        
        //after a delay for some kind of task happening, set it to success
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2), execute: {
            self.alertConfirmVC?.setSuccessThenPauseThenDismiss(milliseconds: 2000)
        })
    }
}

extension ViewController: AlertConfirmationDelegate {
    func buttonClicked(_ no: Int) {
        if no == 0 {
            //ok clicked
            //set it to spinning and perform action associated with ok
            self.alertConfirmVC?.mode = .spinning
            self.okAction()
        }
        if no == 1 {
            //cancel clicked
            self.alertConfirmVC?.dismiss(animated: true, completion: nil)
        }
    }
}

