//
//  CreateTaskView.swift
//  Contactify
//
//  Created by Doni on 6/9/23.
//

import SwiftUI

struct CreateTaskView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var hasError: Bool = false
    
    @ObservedObject var vm: ContactViewModel
    
    var body: some View {
        Form {
            Section {
                TextField("First Name", text: $vm.contact.firstName)
            } header: {
                Text("First Name")
            }
        }
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        
        let preview = ContactsProvider.shared
        
        NavigationStack {
            CreateTaskView(vm: .init(provider: preview))
                .environment(\.managedObjectContext, preview.viewContext)
        }
        
    }
}
