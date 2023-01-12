//
//  ContentView.swift
//  Note_Team
//
//  Created by Nourah Almusaad on 08/01/2023.
//

import SwiftUI

struct MainView: View {
    //  @StateObject var myNotes = MyNotes()
    @EnvironmentObject var myNotesViewModel: MyNotesViewModel
    @State var folderName = ""
    @State var showingPopOver  = false
    @State var showingPopOverDate = false
    let notify = NotificationHandler()
    var body: some View {
        VStack {
            ZStack {
                NavigationStack {
                    // + button
                    headrView
                    //  2nd item
                    HStack {
                        Text("My notes")
                            .font(.largeTitle)
                            .font(Font.custom("SF Pro", size: 50))
                            .accessibility(label: Text("My notes"))
                            .bold()
                        
                        Image("pen")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .accessibility(label: Text("Let's write image"))
                        
                    }
                    List {
                        
                        ForEach (myNotesViewModel.folders) { folder in
                            FolderCell(folder: folder)
                                .background( NavigationLink("", destination:   ListView()).opacity(0) )

                                .swipeActions {
                                    Button(role: .destructive) {
                                    } label: {
                                        Label("Delete", systemImage: "trash.fill")
                                    }
                                    
                                }
                                .accessibility(label: Text("Delete"))
                                .tint(Color("Color 4"))
                                .swipeActions {
                                    Button {
                                        notify.askPermission()
                                        showingPopOverDate.toggle()
                                    } label: {
                                        Label("Reminder",systemImage: "bell" )
                                            .foregroundColor(Color.black)
                                    }
                                    .tint(Color("Gray"))
                                    .accessibility(label: Text("Set a Reminder"))
                                }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .scrollContentBackground(.hidden)
                    
                }
                //Pop box to create new folder name
                if showingPopOver  {
                    NewFolderView(showingPopOver: $showingPopOver)
                }
                
                if showingPopOverDate {
                    Notifications( showingPopOverDate: $showingPopOverDate)
                }
            }
            
        }
        
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(MyNotesViewModel())
    }
}
// Design cell
struct FolderCell: View {
    var folder: MyNotes
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .shadow(radius: 4)
            
                .frame(width: 317, height: 74)
                .overlay(
                    Text(folder.name)
                        .font(.title3)
                        .bold()
                        .swipeActions {
                            Button(role: .destructive) {
                                
                            } label: {
            
                            }
                        }
                )
            Rectangle()
         
                .frame(width: 20, height: 74)
                .padding(.trailing,299)
                .foregroundColor(folder.color)
            
        }
    
    }
}

struct NewFolderView: View {
    @EnvironmentObject var myNotesViewModel: MyNotesViewModel

    @Binding var showingPopOver: Bool
    @State var folderName = ""
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(Color(.systemGray6))
                    .frame(width: geo.size.width * 0.80, height: geo.size.width * 0.50,alignment: .center)
                VStack {
                    Text("New Folder")
                        .font(.title2)
                        .bold()
                        .accessibility(label: Text("New Folder"))
                    
                    Text ("Enter a folder name")
                        .font(.subheadline)
                        .accessibility(label: Text("Enter a folder name"))

                    TextField("Folder name", text: $folderName)
                        .frame(width: 200, height: 10)
                        .padding()
                        .accessibility(label: Text("Folder name"))
                        .background(Color(.white))
                        .cornerRadius(7)
                    Color.gray.frame(width: 315,height: CGFloat(1))
                    ZStack{
                        Color.gray.frame(width: CGFloat(1),height: 20)
                        
                        // stack for save and cancel buttons
                        HStack {
                            //cancel buttons 
                            Text("Cancel")
                                .accessibility(label: Text("Cancel"))
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    showingPopOver = false
                                }
                            
        // Save and add new folder cell button
                            Button(action: {
                                let colors : [Color] = [Color("Pink"),Color("Yellow"),Color("Green"),Color("Babyblue")]
                                let randomColor: Color = colors.randomElement() ?? .green
                                if !folderName.isEmpty {
                                    myNotesViewModel.folders.append(MyNotes(color:randomColor, name: folderName ))
                                    showingPopOver = false
                                }
                                
                            })   {
                                
                                Text("Save")
                                    .frame(maxWidth: .infinity)
                                    .accessibility(label: Text("Add new folder successfully "))

                            }
                        }
                    }
                    
                }
                .frame(width: geo.size.width * 0.80, height: geo.size.width * 0.40)
            }
            .frame(width: geo.size.width , height: geo.size.height, alignment: .center)
        }
    }
}

struct Notifications: View {
    
    @State private var selectedDate = Date()
    let notify = NotificationHandler()
    @Binding var showingPopOverDate: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7)
                .fill(Color(.systemGray6))
            
                .frame(width: 360, height: 150,alignment: .center)
            VStack {
                DatePicker("Pick a date:", selection: $selectedDate, in: Date()...)
                    .bold()
                    .font(.title3)
                    .accessibility(label: Text("Pick date "))
                Button("Set reminder ") {
                    notify.sendNotification(
                        date: selectedDate,
                        type: "date",
                        title: "Hey There! ",
                        body: "This is reminder you to check your list ")
                    showingPopOverDate = false
                }
                .foregroundColor(.white)
                .accessibility(label: Text("Set reminder "))
                .frame(width: 100)
                .padding()
                .background(Color("Color 4"))
                .cornerRadius(16)
                .padding(.horizontal, 40)
                .padding()
                
            }
        }
        
        .frame(width: 250 , height: 120, alignment: .center)
    }
}
extension MainView {
    var headrView: some View {
        HStack (alignment: .top) {
            Spacer()
            Image(systemName: "plus")
            
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color("Color 4"))
                .accessibility(label: Text("Add new folder name"))
                .onTapGesture {
                    showingPopOver.toggle()
                }
                .padding()
        }
    }
}
