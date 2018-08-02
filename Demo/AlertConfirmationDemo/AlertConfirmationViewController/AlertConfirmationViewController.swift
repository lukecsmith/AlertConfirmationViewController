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
    func button1Clicked()
    func button2Clicked()
    func button3Clicked()
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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var successImage: UIImageView!
    @IBOutlet weak var buttonsView: UIStackView!
    @IBOutlet weak var actionViewHeight: NSLayoutConstraint!
    var failedTitle: String?
    var failedMessage: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showActionView(open: false, animated: false)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupWith(title: String, message: String, button1Title: String, button2Title: String?, button3Title: String?, failureTitle: String?, failureMessage: String?, delegate: AlertConfirmationDelegate?) {
        self.titleLabel.text = title
        self.messageLabel.text = message
        self.button1.setTitle(button1Title, for: .normal)
        if let title2 = button2Title {
            self.button2.setTitle(title2, for: .normal)
        } else {
            self.button2.removeFromSuperview()
        }
        if let title3 = button3Title {
            self.button3.setTitle(title3, for: .normal)
        } else {
            self.button3.removeFromSuperview()
        }
        self.delegate = delegate
        self.failedTitle = failureTitle
        self.failedMessage = failureMessage
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
            self.titleLabel.text = self.failedTitle
            self.messageLabel.text = self.failedMessage
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
    
    @IBAction func button1Clicked(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.button1Clicked()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func button2Clicked(_ sender: Any) {
        self.delegate?.button2Clicked()
    }
    
    @IBAction func button3Clicked(_ sender: Any) {
        self.delegate?.button3Clicked()
    }
    
}
