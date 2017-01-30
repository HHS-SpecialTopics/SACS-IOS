//
//  SettingsView.swift
//  SACS
//
//  Created by Merz on 1/26/17.
//  Copyright © 2017 Merz. All rights reserved.
//

import SystemConfiguration
import UIKit

class SettingsView: UIViewController {
    @IBOutlet var webView: UIWebView!
    @IBOutlet var switchDemo: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        //retrieve switches
        switchDemo = UISwitch()
        switchDemo.isOn = true
        switchDemo.addTarget(self, action:#selector(switchValueDidChange), for: UIControlEvents.valueChanged);
        view.addSubview(switchDemo)
    }
    func switchValueDidChange(sender:UISwitch!)
    {
        if (sender.isOn == true){
            OneSignal.sendTag("all notifcations", value: "true")
        }
        else{
            OneSignal.sendTag("all notifcations", value: "false")
        }
    }
}
