//
//  ContentView.swift
//  MNstore
//
//  Created by Алексей on 16.04.2022.
//

import SwiftUI
import CoreData

struct CatalogView: View {

    var body: some View {
        NavigationView{
            VStack{
                CategoryViewList(categoryManager: CategoryManager(categoryId: 0, category: Category(id: 0,
                                                                                                    name: "Каталог",
                                                                                                    parentID: 0,
                                                                                                    active: "Y",
                                                                                                    elementCount: 0)
                ))
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}
