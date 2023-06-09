//
//  DetailsRowInfo.swift
//  Contactify
//
//  Created by Doni on 6/9/23.
//

import SwiftUI

struct DetailsRowInfo: View {
    
    @State var label: String
    @State var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.footnote)
                .foregroundColor(.gray)
            
            Text(value)
                .fontDesign(.rounded)
        }
        .padding(.top, 2)
    }
}

struct DetailsRowInfo_Previews: PreviewProvider {
    static var previews: some View {
        DetailsRowInfo(label: "Alias", value: "Doni")
    }
}
