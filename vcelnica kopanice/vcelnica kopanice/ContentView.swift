//
//  ContentView.swift
//  vcelnica kopanice
//
//  Created by Rastislav Brezovsky on 30/03/2023.
//

import SwiftUI

struct ContentView: View {
@StateObject var family = Families()
@State private var showAddFamily = false

var body: some View {
    NavigationStack {
        List{
            ForEach(family.families) { familia in
                NavigationLink{
                    FamilyView(family: family, familia: familia)
                } label: {
                    Text(familia.name)
                   
                    
                }
            }
            .onDelete(perform: removeItems)
        }
        .navigationTitle("Vcelnice")
        .toolbar {
            Button {
                showAddFamily = true
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showAddFamily) {
            NewFamily(family: family)
        }
    }
}
func removeItems(at offsets: IndexSet) {
    family.families.remove(atOffsets: offsets)
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
