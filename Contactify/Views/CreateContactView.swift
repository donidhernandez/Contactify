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
    
    private let successfulAction: () -> Void
    
    init(vm: ContactViewModel, successfulAction: @escaping () -> Void) {
        self.successfulAction = successfulAction
        self.vm = vm
    }
    
    func create() {
        focusedField = nil
        do {
            try vm.save()
            if vm.state == .successful {
                dismiss()
            }
        } catch {
           print(error)
        }
    }
    
    var body: some View {
        Form {
            Section {
                TextField("First Name", text: $vm.contact.firstName)
                    .focused($focusedField, equals: .firstName)
                    .keyboardType(.namePhonePad)
                    .accessibilityIdentifier("firstNameTxtField")
                TextField("Last Name", text: $vm.contact.lastName)
                    .focused($focusedField, equals: .lastName)
                    .keyboardType(.namePhonePad)
                    .accessibilityIdentifier("lastNameTxtField")
                TextField("Email", text: $vm.contact.email)
                    .focused($focusedField, equals: .email)
                    .keyboardType(.emailAddress)
                    .accessibilityIdentifier("emailTxtField")
                TextField("Phone Number", text: $vm.contact.phoneNumber)
                    .focused($focusedField, equals: .phoneNumber)
                    .keyboardType(.phonePad)
                    .accessibilityIdentifier("phoneNumberTxtField")
                DatePicker("Birthday", selection: $vm.contact.dayOfBirth, displayedComponents: [.date])
                    .datePickerStyle(.compact)
                    .focused($focusedField, equals: .dayOfBirth)
                    .accessibilityIdentifier("birthDayPicker")
                   
                Toggle("Favorite", isOn: $vm.contact.isFavorite)
                    .focused($focusedField, equals: .isFavorite)
                    .accessibilityIdentifier("favoriteToggle")
                
            } header: {
                Text("General")
            }
            
            Section {
                TextField("Notes...", text: $vm.contact.notes)
                    .accessibilityIdentifier("notesTxtField")
                    .focused($focusedField, equals: .notes)
                    
            } header: {
                Text("Notes")
            }
           
        }
        .navigationTitle(vm.isNew ? "New Contact" : "Update Contact")
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button(role: .cancel) {} label: {
                Text("OK")
            }
        }
        .disabled(vm.state == .submitting)
        .onChange(of: vm.state) { formState in
            if formState == .successful {
                dismiss()
                successfulAction()
            }
        }
        .overlay {
            if vm.state == .submitting {
                ProgressView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    create()
                    
                } label: {
                    Text("Done")
                }
                .disabled(!vm.contact.isValid)
                .accessibilityIdentifier("submitBtn")
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                .accessibilityIdentifier("cancelButton")

            }
        }

    }
}

extension CreateContactView {
    enum Field: Hashable {
        case firstName
        case lastName
        case email
        case phoneNumber
        case dayOfBirth
        case isFavorite
        case notes
    }
}

struct CreateContactView_Previews: PreviewProvider {
    static var previews: some View {
        
        let preview = ContactsProvider.shared
     
        NavigationStack {
            CreateContactView(vm: .init(provider: preview)) {}
                .environment(\.managedObjectContext, preview.viewContext)
        }
        
    }
}
