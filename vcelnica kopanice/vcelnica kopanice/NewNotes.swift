//
//  NewNotes.swift
//  vcelnica kopanice
//
//  Created by Rastislav Brezovsky on 05/04/2023.
//

import SwiftUI

struct NewNotes: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var family: Families
    @State private var newNote = ""
    @State private var zaznamCislo = 1
    var familia: Vcelnica
    var ule: Ule
    
    
    
    var body: some View {
        NavigationStack{
            Form {
                VStack{
                    
                    
                    TextField("Note", text: $newNote)
                        .textFieldStyle(.roundedBorder)
                    Button("save") {
                        
                        // First find the index of Family to make modifications
                        if let familyIndex = family.families.firstIndex(of: familia) {
                          // Second find the index of Ul to make modifications
                          if let ulIndex = family.families[familyIndex].ul.firstIndex(where: {ule.id == $0.id}) {
                             let zaznam = Zanam(zaznmaCislo: zaznamCislo, zaznamObsah: newNote)
                             // Then add your zaznam
                             family.families[familyIndex].ul[ulIndex].zaznamy.append(zaznam)
                          }
                        }
                        dismiss()
                        //let index1 = family.families.firstIndex(where: { ule.id == $0.id })
                        //                        let zaznam = Zanam(zaznmaCislo: zaznamCislo, zaznamObsah: newNote)
                        //                        if let index = ule.zaznamy.firstIndex(where: {ule.id == $0.id}) {
                        //                            family.families[].ul[index].zaznamy.append(zaznam)
                        //                        }
                    }
                    .buttonStyle(.bordered)
                }
            }
            //.padding()
            .toolbar {
                Button("Close") {
                    dismiss()
                }
            }
        }
    }
}

struct NewNotes_Previews: PreviewProvider {
    static var previews: some View {
        NewNotes(family: Families(), familia: Families.sample[0], ule: Ule(name: "", cisloUla: 1, cisloMatky: 1, farbaMatky: "", age: 1, zaznamy: []))
    }
}
