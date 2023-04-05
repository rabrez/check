//
//  FamilyView.swift
//  vcelnica kopanice
//
//  Created by Rastislav Brezovsky on 03/04/2023.
//

import SwiftUI
/* We need id to "cheat" a bit our view
We have an issue with @Published variable as
we first add family in [Family] array
So @Published publish changes and our view refreshes
But when we add a person to family.peoples we do not
change @Published property as nothing added to [Family]
as we change peoples inside it, so the variable is not changed
per se and it does't notify us.
So we use that id to change every time when we press + button
and make the view refresh as UUID will be
different every time. Better to find the way to make @Published
property change when underlying data in peoples array added.
 */
struct FamilyView: View {
    @ObservedObject var family: Families
    var familia: Vcelnica
    @State private var showingAddExpense = false
 

    @State private var id = UUID()

    var body: some View {
        List {
            ForEach(familia.ul) { Ule in
                NavigationLink{
                    UlView(family: family, familia: Vcelnica(name: "", ul: []), ule: Ule)
                }label: {
                    
                    VStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.blue)
                        //  .padding(.vertical)
                        HStack(alignment: .bottom){
                            
                            Text("Cislo ula:")
                                .font(.headline)
                            
                            Spacer()
                                .frame(minWidth: 50)
                            ZStack{
                                Image(systemName: "circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25)
                                Text(String(Ule.cisloUla))
                                    .font(.headline)
                                
                            }
                        }
                        
                        HStack{
                            Text("Cislo matky:")
                            Spacer()
                                .frame(minWidth: 50)
                            Text(String(Ule.cisloMatky))
                        }
                        HStack{
                            Text("Farba matky:")
                            Spacer()
                                .frame(minWidth: 50)
                            Text(String(Ule.farbaMatky))
                            Text("zaznamy")
                            Text(String(Ule.zaznamy.count))
                            
                            
                        }
                    }
                }
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
            NewPeople(family: family, familia: familia)
        }
        .onChange(of: showingAddExpense) { _ in
            id = UUID()
        }
    }

    func removeItems(at offsets: IndexSet) {
        if let index = family.families.firstIndex(where: { familia.id == $0.id }) {
            family.families[index].ul.remove(atOffsets: offsets)
        }
    }
}

struct ListFamily_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationStack {
//            FamilyView(family: Families(), familia: Families.sample[0])
//        }
        
        FamilyView(family: Families(), familia: Families.sample[0])
    }
}
