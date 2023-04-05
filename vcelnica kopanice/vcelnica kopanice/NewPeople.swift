//
//  NewPeople.swift
//  vcelnica kopanice
//
//  Created by Rastislav Brezovsky on 03/04/2023.
//

import SwiftUI

struct NewPeople: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var family: Families
    var familia: Vcelnica
    
    @State private var name = ""
    @State private var cisloUla = Int()
    @State private var cisloMatky = Int()
    @State private var farbaMatky = "cervena"
    @State private var age = 10
    
    let farba = ["biela", "žlta", "cervená", "zelená", "modrá"]
    
    var body: some View {
        NavigationStack {
            Form{
                VStack {
                    HStack{
                        Text("Cislo ula")
                        Spacer()
                        TextField("Cislo Ula", value: $cisloUla, format: .number)
                            .frame(width: 50.0)
                            .textFieldStyle(.roundedBorder)
                    }
                    HStack{
                        Text("Cislo matky")
                        Spacer()
                        TextField("Cislo Matky", value: $cisloMatky, format: .number)
                            .frame(width: 50.0)
                            .textFieldStyle(.roundedBorder)
                    }
                    Picker("Farba matky", selection: $farbaMatky) {
                        ForEach(farba, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextField("Age", value: $age, format: .number)
                        .textFieldStyle(.roundedBorder)
              
                Button("Save") {
                    let newPerson = Ule(name: name, cisloUla: cisloUla, cisloMatky: cisloMatky, farbaMatky: farbaMatky, age: age, zaznamy: [])
                    // We got new person, so lets find where it is in our family object in families array
                    // And add that person accordingly
                    if let index = family.families.firstIndex(where: { familia.id == $0.id }) {
                        family.families[index].ul.append(newPerson)
                    }
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                
                //
                    Spacer()
            }
            .padding()
            .toolbar {
                Button("Close") {
                    dismiss()
                }
                }
            }
        }
    }
}

struct NewPeople_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NewPeople(family: Families(), familia: Families.sample[0])
        }
    }
}
