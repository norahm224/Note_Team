//
//  Note_TeamApp.swift
//  Note_Team
//
//  Created by Nourah Almusaad on 08/01/2023.
//

import SwiftUI

@main
struct Note_TeamApp: App {
    @StateObject var myNotesViewModel = MyNotesViewModel()
    @StateObject var listViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(myNotesViewModel)
                .environmentObject(listViewModel)
        }
    }
}
