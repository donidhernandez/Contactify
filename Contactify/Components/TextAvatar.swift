//
//  TextAvatar.swift
//  Contactify
//
//  Created by Doni on 6/9/23.
//

import SwiftUI

struct TextAvatar: View {
    
    @State var text: String
    @State var backgroundColor: Color?
    
    var body: some View {
        Text(text)
            .padding()
            .font(.system(size: 15, design: .rounded).bold())
            .foregroundColor(.white)
            .background(backgroundColor != nil ? backgroundColor : Color.random())
            .clipShape(Circle())
            .frame(width: 75)
    }
}

struct TextAvatar_Previews: PreviewProvider {
    static var previews: some View {
        TextAvatar(text: "DH", backgroundColor: Color("darkblue"))
    }
}
