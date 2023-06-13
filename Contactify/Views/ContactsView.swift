//
//  ContactsView.swift
//  Contactify
//
//  Created by Doni on 6/9/23.
//

import SwiftUI
import CoreData

struct ContactsView: View {
    
    @FetchRequest(fetchRequest: Contact.all()) private var contacts
    let provider = ContactsProvider.shared
    
    @State private var contactToEdit: Contact?
    @State var shouldShowSuccess = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if contacts.isEmpty {
                    NoContactsView()
                } else {
                    List {
                        ForEach(contacts) { contact in
                            ZStack(alignment: .leading) {
                                NavigationLink {
                                    ContactDetailView(contact: contact)
                                } label: {
                                    EmptyView()
                                }
                                .opacity(0)
                                
                                ContactRowView(provider: provider, contact: contact)
                                    .swipeActions(allowsFullSwipe: true) {
                                        
                                        Button(role: .destructive) {
                                            do {
                                                try provider.delete(contact, context: provider.newContext)
                                            } catch {
                                                print(error)
                                            }
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                                .tint(.red)
                                        }
                                        
                                        Button {
                                            contactToEdit = contact
                                        } label: {
                                            Label("Edit", systemImage: "pencil")
                                                .tint(.orange)
                                        }

                                    }
                            }
                        }
                    }
                }
            }
            .sheet(item: $contactToEdit, onDismiss: {
                contactToEdit = nil
            }, content: { contact in
                NavigationStack {
                    CreateContactView(vm: .init(provider: provider, contact: contact)) {
                        haptic(.success)
                        withAnimation(.spring().delay(0.25)) {
                            self.shouldShowSuccess.toggle()
                        }
                    }
                }
            })
            .overlay {
                if shouldShowSuccess {
                    CheckMarkPopoverView()
                        .transition(.scale.combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.spring()) {
                                    self.shouldShowSuccess.toggle()
                                }
                            }
                        }
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        contactToEdit = .empty(context: provider.newContext)
                    } label: {
                        Image(systemName: "plus")
                            .font(.title3)
                            .fontDesign(.rounded)
                    }
                    
                }
            }
            
            
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        let previewProvider = ContactsProvider.shared
        
        ContactsView()
            .environment(\.managedObjectContext, previewProvider.viewContext)
            .onAppear {
                Contact.makePreview(count: 10, in: previewProvider.viewContext)
            }
    }
}
