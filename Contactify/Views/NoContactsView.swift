//
//  NoContactsView.swift
//  Contactify
//
//  Created by Doni on 6/9/23.
//

import SwiftUI

struct NoContactsView: View {
    var body: some View {
        VStack {
            Text("👀 No Contacts")
                .font(.largeTitle.bold())
            Text("It's seems a lil empty here, create some contacts ☝🏻")
                .font(.callout)
        }
    }
}

struct NoContactsView_Previews: PreviewProvider {
    static var previews: some View {
        NoContactsView()
    }
}
