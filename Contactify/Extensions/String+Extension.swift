//
//  String+Extension.swift
//  Contactify
//
//  Created by Doni on 6/9/23.
//

import Foundation

extension String {
    
    func randomEmail(currentStringAsUsername: Bool) -> String {
        let providers = ["gmail.com", "hotmail.com", "icloud.com", "live.com"]
        let randomProvider = providers.randomElement()!
        if currentStringAsUsername {
            return "\(self)@\(randomProvider)"
        }
        let username = UUID.init().uuidString.replacingOccurrences(of: "-", with: "")
        return "\(username)@\(randomProvider)"
    }
}
