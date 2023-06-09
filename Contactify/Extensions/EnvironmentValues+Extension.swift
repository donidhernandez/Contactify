//
//  EnvironmentValues+Extension.swift
//  Contactify
//
//  Created by Doni on 6/9/23.
//

import SwiftUI

extension EnvironmentValues {
    static var isPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
