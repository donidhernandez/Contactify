//
//  CreateContactView.swift
//  Contactify
//
//  Created by Doni on 6/9/23.
//

import SwiftUI

struct CreateContactView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var vm: ContactViewModel
    @FocusState private var focusedField: Field?
    
    var body: some View {
        Form {
            Section {
                TextField("First Name", text: $vm.contact.firstName)
                    .keyboardType(.namePhonePad)
                TextField("Last Name", text: $vm.contact.lastName)
                    .keyboardType(.namePhonePad)
                TextField("Email", text: $vm.contact.email)
                    .keyboardType(.emailAddress)
                TextField("Phone Number", text: $vm.contact.phoneNumber)
                    .keyboardType(.phonePad)
                DatePicker("Birthday", selection: $vm.contact.dayOfBirth, displayedComponents: [.date])
                    .datePickerStyle(.compact)
                Toggle("Favorite", isOn: $vm.contact.isFavorite)
                
            } header: {
                Text("General")
            } footer: {
                
            }
            
            Section {
                TextField("", text: $vm.contact.notes, axis: .vertical)
            } header: {
                Text("Notes")
            }
           
        }
        .navigationTitle(vm.isNew ? "New Contact" : "Update Contact")
    }
}

struct CreateContactView_Previews: PreviewProvider {
    static var previews: some View {
        
        let preview = ContactsProvider.shared
        
        NavigationStack {
            CreateContactView(vm: .init(provider: preview))
                .environment(\.managedObjectContext, preview.viewContext)
        }
        
    }
}
