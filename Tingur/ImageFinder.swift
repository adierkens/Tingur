//
//  ImageHandler.swift
//  Tingur
//
//  Created by Adam Dierkens on 8/28/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import UIKit


class ImageFinder {
    
    let maxQueueSize = 20;
    let errorPicture = UIImage(named: "removed.png");
    var imageQueue : [UIImage];
    var requestsInFlight : Int;
    
    
    init() {
        self.imageQueue = [];
        self.requestsInFlight = 0;
        for x in 0...self.maxQueueSize {
            self.findImage();
        }
    }
    
    func nextImage() -> UIImage {
        
        if self.imageQueue.count + self.requestsInFlight < self.maxQueueSize {
            self.findImage();
        }
        
        while self.imageQueue.count < 1 {
            // Do nothing
        }
        
        return self.imageQueue.removeAtIndex(0);
    }
    
    func findImage() {
        
        {
            self.requestsInFlight++;
            if let url = NSURL(string: "http://i.imgur.com/" + randomStringWithLength(5) + ".png") {
                if let data = NSData(contentsOfURL: url) {
                    if let image = UIImage(data: data) {
                        if (!image.isSame(self.errorPicture!)) {
                            println(url.absoluteString);
                            self.imageQueue.append(image);
                        } else {
                            println("Empty image");
                        }
                    }
                }
            }
            
            
        } ~> {
        
            self.requestsInFlight--;
            
            if self.imageQueue.count < self.maxQueueSize {
                self.findImage();
            }
        }
        
    }
}