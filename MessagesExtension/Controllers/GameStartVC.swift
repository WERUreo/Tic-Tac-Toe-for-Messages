//
//  GameStartVC.swift
//  Tic Tac Toe for Messages
//
//  Created by Keli'i Martin on 9/17/16.
//  Copyright © 2016 WERUreo. All rights reserved.
//

import UIKit

class GameStartVC: UIViewController
{
    var onButtonTap: ((Void) -> Void)?

    ////////////////////////////////////////////////////////////

    @IBAction func startGame(_ sender: AnyObject)
    {
        onButtonTap?()
    }
}
