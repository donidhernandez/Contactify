//
//  ContactifyApp.swift
//  Contactify
//
//  Created by Doni on 6/9/23.
//

import SwiftUI

@main
struct ContactifyApp: App {
    var body: some Scene {
        WindowGroup {
            ContactsView()
                .environment(\.managedObjectContext, ContactsProvider.shared.viewContext)
        }
    }
}
