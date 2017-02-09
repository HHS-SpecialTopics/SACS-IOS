//
//  SettingsView.swift
//  SACS
//
//  Created by Merz on 1/26/17.
//  Copyright © 2017 Merz. All rights reserved.
//

import SystemConfiguration
import UIKit
import OneSignal

class SettingsView: UIViewController {
    @IBOutlet var webView: UIWebView!
    var switches: Array<UISwitch> = Array()
    var settings: Array<String> = Array()
    override func viewDidLoad() {
        super.viewDidLoad()
        //retrieve switches
        settings.append("holder1")
        settings.append("holder2")
        settings.append("all notifcations")
        /*switchDemo = UISwitch()
        switchDemo.isOn = true
        switchDemo.addTarget(self, action:#selector(switchValueDidChange), for: UIControlEvents.valueChanged);*/
        let textview = UITextView(frame: CGRect(x: 20, y: 20, width: self.view.frame.size.width/2, height: self.view.frame.size.height/10))
        textview.text = "texttexttexttexttexttexttexttexttexttexttexttexttext"
        view.addSubview(textview)
        for _ in settings {
            print(settings.count)
            var switchDemo: UISwitch!
            switchDemo = UISwitch()
            switchDemo.isOn = true
            switchDemo.frame.origin.y = CGFloat(switches.count)*self.view.frame.size.height/10
            //view.addSubview(switchDemo)
            switches.append(switchDemo)
            switchDemo.addTarget(self, action:#selector(switchValueDidChange), for: UIControlEvents.valueChanged);
        }


    }
    func switchValueDidChange(sender:UISwitch!)
    {
        let setting = settings[switches.index(of: sender)!]
        print(setting)
        if (sender.isOn == true){
            OneSignal.sendTag(setting, value: "true")
        }
        else{
            OneSignal.sendTag(setting, value: "false")
        }
    }
}
