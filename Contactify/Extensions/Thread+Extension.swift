//
//  Thread+Extension.swift
//  Contactify
//
//  Created by Doni on 6/13/23.
//

import Foundation

extension Thread {
    var isRunningXCTest: Bool {
        for key in self.threadDictionary.allKeys {
            guard let keyAsString = key as? String else {
                continue
            }
            
            if keyAsString.split(separator: ".").contains("xctest") {
                return true
            }
        }
        
        return false
    }
}
