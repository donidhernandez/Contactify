//
//  Color+Extension.swift
//  Contactify
//
//  Created by Doni on 6/9/23.
//

import SwiftUI

extension Color {
    static func random() -> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
