//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Mary Moreira on 24/10/2022.
//

import SwiftUI

struct NewTaskItemView: View {
    //MARK: - Properties
    @State var task: String = ""
    @Binding var isShowing: Bool
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    //MARK: - Fetching data
    @Environment(\.managedObjectContext) private var viewContext
    
    private var isButtonDisabled: Bool {
        task.isEmpty
    }
    
    //MARK: - Functions
    
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            task = ""
            hideKeyboard()
            isShowing = false
        }
    }
    
    //MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16){
                TextField("New task", text: $task)
                    .padding()
                    .foregroundColor(.pink)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .background(
                        isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                
                Button(action: {
                    addItem()
                    playSound(sound: "sound-ding", type: "mp3")
                    feedback.notificationOccurred(.success)
                }, label: {
                    Spacer()
                    Text("Save")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Spacer()
                })
                .disabled(isButtonDisabled)
                .onTapGesture(perform: {
                    if isButtonDisabled {
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                })
                .padding()
                .foregroundColor(.white)
                .background(isButtonDisabled ? Color.blue : Color.pink)
                .cornerRadius(10)
            } //VSTACK
            .padding(.horizontal)
            .padding(.vertical)
            .background(
                isDarkMode ? Color(UIColor.secondarySystemBackground) : .white)
            .cornerRadius(16)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
            .frame(maxWidth: 640)
            
        }//VStack
        .padding()
    }
}

struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskItemView(isShowing: .constant(true))
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
