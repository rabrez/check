//
//  Struktura.swift
//  vcelnica kopanice
//
//  Created by Rastislav Brezovsky on 30/03/2023.
//

import Foundation




struct Vcelnica: Codable, Identifiable, Equatable{
    var id = UUID()
    let name: String
    var ul: [Ule]
    static func == (lhs: Vcelnica, rhs: Vcelnica) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Ule: Codable, Identifiable,Equatable {
    static func == (lhs: Ule, rhs: Ule) -> Bool {
        return lhs.id == rhs.id
    }
    
   
    var id = UUID()
    let name: String
    let cisloUla: Int
    let cisloMatky: Int
    let farbaMatky: String
    let age: Int
    var zaznamy: [Zanam]
}

struct Zanam: Codable, Identifiable {
    var id = UUID()
    let zaznmaCislo: Int
    let zaznamObsah: String
}




class Families: ObservableObject {
    static var sample = [Vcelnica(name: "Family One", ul: [Ule(name: "Person One", cisloUla: 1, cisloMatky: 1, farbaMatky: "modra", age: 1, zaznamy: [(Zanam(zaznmaCislo: 1, zaznamObsah: "test1"))] ), Ule(name: "Person Two", cisloUla: 2, cisloMatky: 2, farbaMatky: "modra", age: 2, zaznamy: [(Zanam(zaznmaCislo: 2, zaznamObsah: "test2"))])])]

    @Published var families = [Vcelnica]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(families) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([Vcelnica].self, from: savedItems) {
                families = decodedItems
                return
            }
        }

        families = []
    }

}
