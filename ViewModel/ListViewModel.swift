//
//  ListViewModel.swift
//  Note_Team
//
//  Created by Nourah Almusaad on 12/01/2023.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = []
    
    init() {
        getItems()
    }
    
    func getItems() {
        let newItems = [
            ItemModel(title:NSLocalizedString( "attend meeting", comment: ""), isComoleated: false),
            ItemModel(title: NSLocalizedString("Discuess final design ", comment: ""), isComoleated: true),
            ItemModel(title: NSLocalizedString("Develop sign in page", comment: ""), isComoleated: false),
            ItemModel(title: NSLocalizedString("Develop user account page" , comment: ""), isComoleated: true)
        ]
        items.append(contentsOf: newItems)
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
        
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isComoleated: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        
        if let index = items.firstIndex { (existingItem) -> Bool in
            return existingItem.id == item.id
        } {
        }
        if let index = items.firstIndex(where: { $0.id == item.id}) {
            items[index] = item.updateCompletion()
            items[index] = item.updateCompletion()
        }
    }
}
