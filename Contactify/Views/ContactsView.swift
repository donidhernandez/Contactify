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
    
    @State private var searchConfig: SearchConfig = .init()
    @State private var sort: Sort = .asc
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
            .searchable(text: $searchConfig.query)
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
            .onChange(of: searchConfig, perform: { newConfig in
                contacts.nsPredicate = Contact.filter(with: newConfig)
            })
            .onChange(of: sort, perform: { newSort in
                contacts.nsSortDescriptors = Contact.sort(order: newSort)
            })
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
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Picker(selection: $searchConfig.filter) {
                            Text("All").tag(SearchConfig.Filter.all)
                            Text("Favorites").tag(SearchConfig.Filter.fave)
                        } label: {
                            Text("Filter By")
                        }
                        .pickerStyle(.menu)
                        
                        
                        Picker(selection: $sort) {
                            Label("Asc", systemImage: "arrow.up").tag(Sort.asc)
                            Label("Desc", systemImage: "arrow.down").tag(Sort.desc)
                        } label: {
                            Text("Sort By")
                        }
                        .pickerStyle(.menu)


                    } label: {
                        Image(systemName: "ellipsis")
                            .symbolVariant(.circle)
                            .font(.title2)
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
