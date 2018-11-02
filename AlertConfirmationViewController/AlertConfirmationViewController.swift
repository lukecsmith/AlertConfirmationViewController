//
//  AlertConfirmationViewController.swift
//  Sensium Mobile Demo
//
//  Created by Luke Smith on 25/07/2018.
//  Copyright © 2018 Sensium Healthcare Ltd. All rights reserved.
//

import Foundation
import UIKit

protocol AlertConfirmationDelegate: class {
    func buttonClicked(_ no: Int)
}

enum AlertConfirmationMode {
    case choose
    case spinning
    case success
    case failure
}

class AlertConfirmationViewController: UIViewController {
    
    weak var delegate: AlertConfirmationDelegate?
    var mode : AlertConfirmationMode = .choose {
        didSet {
            self.modeChanged()
        }
    }
    var titleText = "set a title"
    var messageText = "set a message"
    var btn0Text = "Ok"
    var btn1Text : String?
    var btn2Text : String?
    var failedTitleText = "set failure title"
    var failedMessageText = "set failure message"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var successImage: UIImageView!
    @IBOutlet weak var buttonsView: UIStackView!
    @IBOutlet weak var actionViewHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.showActionView(open: false, animated: false)
    }
    
    func setupView() {
        self.titleLabel.text = self.titleText
        self.messageLabel.text = self.messageText
        self.button0.setTitle(self.btn0Text, for: .normal)
        if let title1 = self.btn1Text {
            self.button1.setTitle(title1, for: .normal)
        } else {
            self.button1.removeFromSuperview()
        }
        if let title2 = self.btn2Text {
            self.button2.setTitle(title2, for: .normal)
        } else {
            self.button2.removeFromSuperview()
        }
    }
    
    func modeChanged() {
        switch self.mode {
        case .choose:
            self.spinner.isHidden = true
            self.successImage.isHidden = true
            self.buttonsView.isUserInteractionEnabled = true
            self.showActionView(open: false, animated: false)
        case .spinning:
            self.spinner.isHidden = false
            self.successImage.isHidden = true
            self.buttonsView.isUserInteractionEnabled = false
            self.showActionView(open: true, animated: true)
        case .failure:
            self.spinner.isHidden = true
            self.successImage.isHidden = false
            self.successImage.image = UIImage(named: "cancel-square-128")
            self.titleLabel.text = self.failedTitleText
            self.messageLabel.text = self.failedMessageText
            self.buttonsView.isUserInteractionEnabled = true
        case .success:
            self.spinner.isHidden = true
            self.successImage.isHidden = false
            self.successImage.image = UIImage(named: "accept-square-128")
            self.buttonsView.isUserInteractionEnabled = false
        }
    }
    
    func showActionView(open : Bool, animated: Bool) {
        if open {
            self.actionViewHeight.constant = 37
        } else {
            self.actionViewHeight.constant = 0
        }
        if animated {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            self.view.layoutIfNeeded()
        }
    }
    
    func setSuccessThenPauseThenDismiss(milliseconds: Int) {
        self.mode = .success
        //after another delay, remove the AlertConfirmVC
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(milliseconds), execute: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    @IBAction func button0Clicked(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.buttonClicked(0)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func button1Clicked(_ sender: Any) {
        self.delegate?.buttonClicked(1)
    }
    
    @IBAction func button2Clicked(_ sender: Any) {
        self.delegate?.buttonClicked(2)
    }
    
}
