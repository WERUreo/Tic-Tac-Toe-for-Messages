//
//  UIImage+Snapshot.swift
//  Tic Tac Toe for Messages
//
//  Created by Keli'i Martin on 9/19/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import UIKit

extension UIImage
{
    /// Create an image represenation of the given view
    class func snapshot(from view: UIView) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)

        let snapshot = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return snapshot!
    }
}
