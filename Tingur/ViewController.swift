//
//  ViewController.swift
//  Tingur
//
//  Created by Adam Dierkens on 8/28/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imageFinder : ImageFinder!
    
    @IBAction func swipeAction(sender: UISwipeGestureRecognizer) {
        NSLog("swipe");
        self.pictureView.image = self.imageFinder.nextImage();
    }
    @IBOutlet weak var pictureView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.imageFinder = ImageFinder();
        pictureView.image = self.imageFinder.nextImage();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}