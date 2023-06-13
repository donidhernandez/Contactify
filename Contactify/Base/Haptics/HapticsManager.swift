//
//  HapticsManager.swift
//  Contactify
//
//  Created by Doni on 6/12/23.
//

import Foundation
import UIKit

final class HapticsManager {
    
    static let shared = HapticsManager()
    private let feedback =  UINotificationFeedbackGenerator()
    
    private init() {}
    
    func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        feedback.notificationOccurred(notification)
    }
}

func haptic(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
    if UserDefaults.standard.bool(forKey: UserDefaultKeys.hapticsEnabled) {
        HapticsManager.shared.trigger(notification)
    }
}
