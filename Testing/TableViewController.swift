//
//  TableViewController.swift
//  Testing
//
//  Created by Merz on 10/7/16.
//  Copyright © 2016 Merz. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {
    //@IBOutlet var tableView: UITableView!
    let myarray = ["item1", "item2", "item3"]
    let images = ["homesteadhigh"]
    var pageToOpen = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "customcell")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myarray.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = myarray[indexPath.item]
        if indexPath.item<images.count {
            let image : UIImage = UIImage(named: images[indexPath.item])!
            cell.imageView?.image = image
        }
        return cell
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        let rowIndexPath = tableView.indexPathForSelectedRow!
        /*let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let userVC = mainStoryboard.instantiateViewControllerWithIdentifier("WebViewControlID") //as! UserViewController
        presentViewController(userVC, animated: true, completion: nil) // this seems to not call prepareForSegue, is it something different?
        */

        var nameString:String
        var segueString:String
        nameString = self.myarray[rowIndexPath.row].lowercased()
        segueString = nameString + "View"
        print(segueString)
        //self.performSegueWithIdentifier(segueString, sender: self)
        let pages=[51,54,56]
        pageToOpen = pages[rowIndexPath.row]
        self.performSegue(withIdentifier: "toWebView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        //segue may not be as broad as I first imagined, consider creating one from this to webview so this method is called
        
        
        //doesn't currently enter this; perhaps it isn't using segue to transition?
        let destinationViewController = segue.destination as! WebView
        destinationViewController.test = pageToOpen
    }
}
