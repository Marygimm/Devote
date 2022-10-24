//
//  ListRowItemView.swift
//  Devote
//
//  Created by Mary Moreira on 24/10/2022.
//

import SwiftUI

struct ListRowItemView: View {
    //MARK: - Properties
    @ObservedObject var item: Item
    //MARK: - Fetching data
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? Color.pink : Color.primary)
                .padding(.vertical, 12)
                .animation(.default, value: UUID())
        }//: Toggle
        .toggleStyle(CheckboxStyle())
        .onReceive(item.objectWillChange) { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        }
    }
}

