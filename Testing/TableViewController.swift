//
//  TableViewController.swift
//  Testing
//
//  Created by Merz on 10/7/16.
//  Copyright © 2016 Merz. All rights reserved.
//

import Foundation
import UIKit
import OneSignal

class TableViewController: UITableViewController {
    //@IBOutlet var tableView: UITableView!
    //let myarray = ["item1", "item2", "item3"]
    let images = ["homesteadhigh"]
    var pageToOpen = 0
    var settings: Array<String> = Array()
    var settingsNS = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        settings.append("Delays")
        settings.append("Cancellations")
        settings.append("News articles")
        settings.append("Other")
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "customcell")
        self.tableView.allowsSelection = false
        navigationItem.title = "Settings"
        self.navigationController?.isNavigationBarHidden = false
        //navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.backgroundColor = UIColor.white
        self.tableView.tableFooterView = UIView(frame: CGRect())
        
        //first launch code; currently to enable all settings
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            
        } else {
            for x in 0...(settings.count-1)
            {
                OneSignal.sendTag(settings[x], value: "true")
                settingsNS.set(true, forKey: settings[x])
            }
            print("First launch, enabling notifications.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
    }


    /*override var prefersStatusBarHidden: Bool {
        return true
    }*/
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Notifications"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count;
    }
    
    var switches: Array<UISwitch> = Array()
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //pageToOpen = pageToOpen + 1
        //print("times \(pageToOpen)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = settings[indexPath.item]
        var switchDemo: UISwitch!
        switchDemo = UISwitch()
        switchDemo.isOn = settingsNS.bool(forKey: settings[indexPath.item])
        //finds mid y cordinant of cell; subtracts cell height*number of cells to make sure it is in the right cell, every cell it adds an extra cell's worth of height to .midY; subtracts 1/2 switch height to center switch
        switchDemo.frame.origin.y = cell.frame.midY-cell.frame.height*CGFloat(indexPath.item)-switchDemo.frame.height/2
        switchDemo.frame.origin.x = cell.frame.width*0.8
        switchDemo.addTarget(self, action:#selector(buttonClicked), for: UIControlEvents.valueChanged)
        switches.append(switchDemo)
        cell.addSubview(switchDemo)
        return cell
        /*if indexPath.item<images.count {
         let image : UIImage = UIImage(named: images[indexPath.item])!
         cell.imageView?.image = image
         }*/
         /*let cell = UITableViewCell()
         let label = UILabel(frame: CGRect(x:0, y:0, width:200, height:50))
         label.text = "test"
         cell.addSubview(label)
         return cell*/
        //let cell = tableView.dequeueReusableCellWithIdentifier("customcell", forIndexPath: indexPath)
        /*let cell = tableView.dequeueReusableCellWithIdentifier("customcell", forIndexPath: indexPath) as UITableViewCell
        let label = UILabel(frame: CGRect(x:0, y:0, width:200, height:50))
        label.text = "test"
        cell.addSubview(label)
        return cell*/
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let rowIndexPath = tableView.indexPathForSelectedRow!
        /*let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let userVC = mainStoryboard.instantiateViewControllerWithIdentifier("WebViewControlID") //as! UserViewController
        presentViewController(userVC, animated: true, completion: nil) // this seems to not call prepareForSegue, is it something different?
        */

        
        
        /*var nameString:String
        var segueString:String
        nameString = self.myarray[rowIndexPath.row].lowercased()
        segueString = nameString + "View"
        print(segueString)
        //self.performSegueWithIdentifier(segueString, sender: self)
        let pages=[51,54,56]
        pageToOpen = pages[rowIndexPath.row]
        self.performSegue(withIdentifier: "toWebView", sender: self)*/
    }
    
    @IBAction func buttonClicked(sender: UISwitch){
        //let switchIndex = 0
        let switchIndex = switches.index(of: sender)!
        let setting = settings[switchIndex]
        if (switches[switchIndex].isOn == true){
            OneSignal.sendTag(setting, value: "true")
            settingsNS.set(true, forKey: setting)
        }
        else{
            OneSignal.sendTag(setting, value: "false")
            settingsNS.set(false, forKey: setting)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        //segue may not be as broad as I first imagined, consider creating one from this to webview so this method is called
        
        
        //doesn't currently enter this; perhaps it isn't using segue to transition?
        let destinationViewController = segue.destination as! WebView
        //destinationViewController.test = pageToOpen //note test does not exist anymore, this was a test
    }
}
