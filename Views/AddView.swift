//
//  AddView.swift
//  Note_Team
//
//  Created by Nourah Almusaad on 12/01/2023.
//
import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here..",text: $textFieldText)
                    .padding(.horizontal)
                    .accessibility(label: Text("Type something here.."))
                    .frame(height: 57)
                    .background(Color(hue: 0.601, saturation: 0.229, brightness: 1.0))
                    .cornerRadius(15)
                
                Button(action: saveButtonPressed,label: {
                    Text("Save")
                        .foregroundColor(.white)
                        .accessibility(label: Text("Save"))
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(15)
                    
                })
            }
            .padding(14)
            
        }
        .navigationTitle("Add a task 📝")
        .alert(isPresented: $showAlert, content: getAlert)
        .accessibility(label: Text("Add a task 📝"))
    }
    func saveButtonPressed() {
        if textIsAppropriate() == true {
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
    }
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "your tasks item must be at least 3 charecters long.."
            showAlert.toggle()
            return false
        }
        return true
    }
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
        }
        .environmentObject(ListViewModel())
    }
}
