//
//  ListView.swift
//  Note_Team
//
//  Created by Nourah Almusaad on 08/01/2023.
//

import SwiftUI

struct ListView: View {

@EnvironmentObject var listViewModel: ListViewModel

var body: some View {
    List {
        ForEach(listViewModel.items) { items in
            ListRowView(item: items)
                .onTapGesture {
                    withAnimation(.linear) {
                        listViewModel.updateItem(item: items)
                        
                    }
                }
            
        }
        .onDelete(perform: listViewModel.deleteItem)
        .onMove(perform: listViewModel.moveItem)
        
    }
    .padding()
        .listStyle(PlainListStyle())
        .navigationTitle("To Do List ✏️")
        .accessibility(label: Text("To Do List ✏️"))
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink("Add", destination: AddView())
          )
        
            
   
    }
}
    
                

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}
