//
//  CheckMarkPopoverView.swift
//  Contactify
//
//  Created by Doni on 6/12/23.
//

import SwiftUI

struct CheckMarkPopoverView: View {
    var body: some View {
        Image(systemName: "checkmark")
            .font(.system(.largeTitle, design: .rounded).bold())
            .padding()
            .background(Color.green.gradient.opacity(0.6))
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 25, style: .continuous))
    }
}

struct CheckMarkPopoverView_Previews: PreviewProvider {
    static var previews: some View {
        CheckMarkPopoverView()
    }
}
