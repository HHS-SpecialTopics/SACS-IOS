//
//  ViewController.swift
//  Testing
//
//  Created by Merz on 10/7/16.
//  Copyright © 2016 Merz. All rights reserved.
//

import UIKit
import Foundation

class WebView: UIViewController, UIWebViewDelegate {
    @IBOutlet var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        let url = "http://sacs.school"//https://sacs-backend-chrisblutz.c9users.io/ or https://sacs-sacsnews.c9users.io
        // pages on 51,54,56
        let requestURL = URL(string:url)
        let requesting = URLRequest(url: requestURL!)
        webView.loadRequest(requesting)
        self.navigationController?.isNavigationBarHidden = true
        /*let notification = UILocalNotification()
        notification.alertBody = "test" // text that will be displayed in the notification
        notification.alertAction = "open"
        notification.fireDate = Date(timeIntervalSinceReferenceDate: 5) // todo item due date (when notification will be fired) notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        // Do any additional setup after loading the view, typically from a nib.
        UIApplication.shared.scheduleLocalNotification(notification)*/
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("entered webView")
        switch navigationType {
        case .linkClicked:
            print("link")
            // Open links in Safari
            guard let url = request.url else { return true }
            if(url.absoluteString.range(of: "sacs://") != nil )
            {
                print("got request")
                // parse custom URL to extract parameter
                if(url.absoluteString.range(of: "settings") != nil ){
                    self.performSegue(withIdentifier: "showTable", sender: self)//showSetting as identifier
                }
                return false; // return false, so webView won't actually try to load this fake request
            }
            if (url.absoluteString.range(of: "sacsnews") != nil) {
                return true
            } else {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    // openURL(_:) is deprecated in iOS 10+.
                    UIApplication.shared.openURL(url)
                }
            }
            return false
        default:
            print("default")
                        // Handle other navigation types...
            return true
        }
    }
}
