//
//  Utils.swift
//  Tingur
//
//  Created by Adam Dierkens on 8/28/15.
//  Copyright (c) 2015 Adam Dierkens. All rights reserved.
//

import UIKit


//: http://www.raywenderlich.com/80818/operator-overloading-in-swift-tutorial
infix operator ~> {}

private let queue = dispatch_queue_create("serial-worker", DISPATCH_QUEUE_SERIAL);

func ~> (async : ()->(), main : ()->()) {
    dispatch_async(queue) {
        async();
        dispatch_async(dispatch_get_main_queue(), main);
    }
}

func ~> <T> (async : () -> T, main : (result : T) -> ()) {
    dispatch_async(queue) {
        let x = async();
        dispatch_async(dispatch_get_main_queue(), {
            main(result: x);
        });
    }
}


// x ❤️️ y
infix operator ❤️️ {}
func ❤️️(left: AnyObject, right: AnyObject) -> Bool {
    return left.isEqual(right);
}


//: http://stackoverflow.com/questions/26845307/generate-random-alphanumeric-string-in-swift

func randomStringWithLength (len : Int) -> String {
    
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    var randomString : NSMutableString = NSMutableString(capacity: len)
    
    for (var i=0; i < len; i++){
        var length = UInt32 (letters.length)
        var rand = arc4random_uniform(length)
        randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
    }
    
    return randomString as String!
}

extension UIImage {
    
    func isSame(other: UIImage) -> Bool {
        
        let data1 = UIImagePNGRepresentation(self);
        let data2 = UIImagePNGRepresentation(other);
        return data1 == data2;
        
    }
    
}