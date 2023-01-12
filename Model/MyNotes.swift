//
//  MyNotes.swift
//  Note_Team
//
//  Created by Nourah Almusaad on 09/01/2023.
//

import Foundation
import SwiftUI


class MyNotesViewModel: ObservableObject {
    @Published var folders = MyNotes.testFolder
}

struct MyNotes: Identifiable {
    var id = UUID()
   var color: Color
    var name: String
}

extension MyNotes {
    static let testFolder = [
        MyNotes( color: Color("Pink"), name: NSLocalizedString("Work", comment: "")),
        MyNotes( color: Color("Yellow"), name: NSLocalizedString("House furniture", comment: "")),
        MyNotes(color: Color("Green"), name:  NSLocalizedString("Spending", comment: ""))
    ]

}
