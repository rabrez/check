//
//  UlView.swift
//  vcelnica kopanice
//
//  Created by Rastislav Brezovsky on 04/04/2023.
//

import SwiftUI

struct UlView: View {
    @ObservedObject var family: Families
    var familia: Vcelnica
    var ule: Ule
    @State private var showingAddExpense = false
    @State private var id = UUID()
    
    
    
    
    var body: some View {
        List {
            ForEach(ule.zaznamy) { ul in
                Text("toto je zaznan \(ul.zaznamObsah)")
                
            }
            .onDelete(perform: removeItems)

        }
        .toolbar {
            Button {
                showingAddExpense = true
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            NewNotes(family: family,familia: familia, ule: ule)
        }
        .onChange(of: showingAddExpense) {_ in
            id = UUID()
        }
    }
    func removeItems(at offsets: IndexSet) {
        if let index = family.families.firstIndex(where: { familia.id == $0.id }) {
            family.families[index].ul[index].zaznamy.remove(atOffsets: offsets)
        }
    }
}
struct UlView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FamilyView(family: Families(), familia: Families.sample[0])
        }
        
       // FamilyView(family: Families(), familia: Families.sample[0])
    }
}

