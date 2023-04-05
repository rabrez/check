//
//   NewFamily.swift
//  vcelnica kopanice
//
//  Created by Rastislav Brezovsky on 03/04/2023.
//

import SwiftUI

struct NewFamily: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var family: Families
    @State private var name = ""

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Nova vcelnica", text: $name)
                    .textFieldStyle(.roundedBorder)

                Button("Save") {
                    let newFamily = Vcelnica(name: name, ul: [])
                    // We got name for new family so let's add it to our family object
                    family.families.append(newFamily)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)

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

struct NewFamily_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NewFamily(family: Families())
        }
    }
}
