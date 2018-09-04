//
//  String+Extension.swift
//  CodeChallenge
//
//  Created by Jorge Mendoza on 9/2/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import Foundation
extension String {
    
    func removeHTMLTags() -> String {
        
        return self.replacingOccurrences(of: "<p>", with: "")
            .replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "<i>", with: "")
            .replacingOccurrences(of: "</p>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
            .replacingOccurrences(of: "</i>", with: "")
    }
    
    func getYear() -> String {
        
        let indexTo = self.index(self.startIndex, offsetBy: 3)
        
        return String(self[...indexTo])
    }
}
