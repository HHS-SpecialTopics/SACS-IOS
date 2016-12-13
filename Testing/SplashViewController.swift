//
//  ViewController.swift
//  Testing
//
//  Created by Merz on 10/7/16.
//  Copyright © 2016 Merz. All rights reserved.
//

import UIKit


class SplashViewController: UIViewController {
    @IBOutlet var webView: UIWebView!
    override func viewDidLoad() {
        //print("Reached loading of splash screen")
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        // Get the Document directory path
        let documentDirectorPath:String = paths[0]
        // Create a new path for the new images folder
        let imagesDirectoryPath = documentDirectorPath + "/SplashScreen"
        var objcBool:ObjCBool = true
        let isExist = FileManager.default.fileExists(atPath: imagesDirectoryPath, isDirectory: &objcBool)
        // If the folder with the given path doesn't exist already, create it
        if isExist == false{
            do{
                try FileManager.default.createDirectory(atPath: imagesDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print("this folder already exists - or something went wrong")
            }
        }
        super.viewDidLoad()
        
        addBackgroundImage()
        //addLogo()
        
        // Show the home screen after a bit. Calls the show() function.
        //self.show()
        Timer.scheduledTimer(
            timeInterval: 2.5, target: self, selector: #selector(self.showNext), userInfo: nil, repeats: false
        )
    }
    
    /*
     * Gets rid of the status bar
     *
     override func prefersStatusBarHidden(); -&gt; Bool {
     return true
     }*/
    
    /*
     * Shows the app's main home screen.
     * Gets called by the timer in viewDidLoad()
     */
    func showNext() {
        self.performSegue(withIdentifier: "showApp", sender: self)
    }
    
    /*
     * Adds background image to the splash screen
     */
    func addBackgroundImage() {
        let screenSize: CGRect = UIScreen.main.bounds
        var bg = UIImage()
        let url = URL(string: "https://sacs-backend-chrisblutz.c9users.io/wp-content/uploads/2016/12/SplashScreen.png")
        //http://pngimagesfree.com/NATURE/Grass/grass_png_paradise.png
        //http://pngimg.com/upload/small/Acorn_PNG744.png
        //http://pngimg.com/upload/grass_PNG10863.png
        //http://www.pngpix.com/wp-content/uploads/2016/03/Gorilla-PNG-Image.png
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        // Get the Document directory path
        let documentDirectorPath:String = paths[0]
        // Set the path for the images
        let localImagesDirectoryPath = documentDirectorPath + "/SplashScreen/default.png"
        if (try? Data(contentsOf: url!)) != nil{ //note that this only ensures there is a file, it doesn't validate the pictureness of it
            let data = try? Data(contentsOf: url!)
            //if UIImage(data: data!) != nil{ //may be needed, if there is a risk of non-picture files at link. No file at link is safe and fails the NSData if
            bg = UIImage(data: data!)!
            //} else{
            
            FileManager.default.createFile(atPath: localImagesDirectoryPath, contents: data, attributes: nil)
        } else{
            print("failed to contact website")
            bg = UIImage(contentsOfFile: localImagesDirectoryPath)!
        }
        //print(localImagesDirectoryPath)
        let bgView = UIImageView(image: bg)
        
        bgView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        self.view.addSubview(bgView)
    }
    
    /*
     * Adds logo to splash screen
     */
    func addLogo() {
        let screenSize: CGRect = UIScreen.main.bounds
        let url = URL(fileURLWithPath: "http://www.sacs.k12.in.us//cms/lib07/IN01907860/Centricity/Domain/4/jg.jpg")//can't take jpgs?
        let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        let logo = UIImage(data: data!)
        
        //let logo     = UIImage(named: "homesteadhigh.png")
        let logoView = UIImageView(image: logo)
        
        let w = logo?.size.width
        let h = logo?.size.height
        
        logoView.frame = CGRect( x: (screenSize.width/2) - (w!/2), y: 5, width: w!, height: h! )
        self.view.addSubview(logoView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}





