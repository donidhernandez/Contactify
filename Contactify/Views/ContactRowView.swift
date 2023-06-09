//
//  ContactRowView.swift
//  Contactify
//
//  Created by Doni on 6/9/23.
//

import SwiftUI

struct ContactRowView: View {
    
    @Environment(\.managedObjectContext) private var moc
    
    let provider: ContactsProvider
    @ObservedObject var contact: Contact
    @State var hasError: Bool = false
    
    var body: some View {
        HStack {
            if contact.firstName != "" && contact.lastName != "" {
                TextAvatar(text: "\(contact.firstName.first!)\(contact.lastName.first!)")
            }
            
            
            Text("\(contact.firstName) \(contact.lastName)")
                .font(.subheadline.bold())
                .fontDesign(.rounded)
            
            Spacer()
            
            Button {
                toggleFave()
            } label: {
                Image(systemName: "heart")
                    .font(.title3)
                    .symbolVariant(.fill)
                    .foregroundColor(contact.isFavorite ? .pink : .gray.opacity(0.3))
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .alert(isPresented: $hasError) {
            Alert(title: Text("An error has ocurred"))
        }
    }
}

private extension ContactRowView {
    func toggleFave() {
        withAnimation(.easeIn(duration: 0.5)) {
            contact.isFavorite.toggle()
        }
        
        do {
            try provider.persists(in: moc)
        } catch {
            self.hasError = true
        }
    }
}

struct ContactRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        let previewProvider = ContactsProvider.shared
        
        ContactRowView(provider: previewProvider, contact: .preview(context: previewProvider.viewContext))
    }
}
