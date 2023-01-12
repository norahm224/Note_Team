//
//  itemModel.swift
//  Note_Team
//
//  Created by Nourah Almusaad on 12/01/2023.
//
import Foundation

struct ItemModel: Identifiable {
let id: String
let title: String
let isCompleted: Bool

init(id: String = UUID().uuidString, title: String, isComoleated: Bool) {
    self.id = id
    self.title = title
    self.isCompleted = isComoleated
}

func updateCompletion() -> ItemModel {
    return ItemModel(id: id, title: title, isComoleated: !isCompleted)
}
}
