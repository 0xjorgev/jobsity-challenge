//
//  UILabel+Extension.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/3/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{

    func addRoundedCorners() -> Void {
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
    }
}
