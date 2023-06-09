//
//  Header.swift
//  Contactify
//
//  Created by Doni on 6/9/23.
//

import SwiftUI

struct Header: View {
    
    @State var firstName: String
    @State var lastName: String
    @State var phoneNumber: String
    @State var isFavorite: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("darkblue").gradient)
            
            VStack(spacing: 15) {
                if firstName != "" && lastName != "" {
                    TextAvatar(text:"\(firstName.first!)\(lastName.first!)", backgroundColor: Color("darkblue"))
                }
                HStack {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .symbolRenderingMode(.multicolor)
                    
                    Text("\(firstName) \(lastName)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                
                HStack(spacing: 5) {
                    Text("Cellphone: ")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .fontDesign(.rounded)
                    
                    Text(phoneNumber)
                        .font(.body)
                        .foregroundColor(.white)
                        .bold()
                }
            }
            .padding(.top, 50)
            .padding(.bottom, 10)
        }
        .ignoresSafeArea(.all, edges: .top)
        .frame(height: 200)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(firstName: "Doni", lastName: "Hernandez", phoneNumber: "+5354497124", isFavorite: false)
    }
}
