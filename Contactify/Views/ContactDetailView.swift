//
//  ContactDetailView.swift
//  Contactify
//
//  Created by Doni on 6/9/23.
//

import SwiftUI

struct ContactDetailView: View {
    
    @ObservedObject var contact: Contact
    let provider = ContactsProvider.shared
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Header(firstName: contact.firstName, lastName: contact.lastName, phoneNumber: contact.phoneNumber, isFavorite: contact.isFavorite)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Section(header: Text("Basic Information")
                            .font(.headline)
                            .bold()
                            .fontDesign(.rounded)
                            .foregroundColor(Color("darkblue"))
                        ) {
                            DetailsRowInfo(label: "Email", value: contact.email)
                            VStack(alignment: .leading) {
                                Text("Birthday")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                
                                Text(contact.dayOfBirth, style: .date)
                                    .fontDesign(.rounded)
                            }
                            .padding(.top, 2)
                            DetailsRowInfo(label: "Notes", value: contact.notes)
                        }
                    }
                    
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
        }
    }
}

struct ContactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let preview = ContactsProvider.shared
        
        ContactDetailView(contact: .preview(context: preview.viewContext))
    }
}
