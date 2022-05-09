//
//  NavBarView.swift
//  MNstore
//
//  Created by Алексей on 16.04.2022.
//

import SwiftUI

enum Tab: Hashable {
    case catalog
    case cart
    case settings
}

struct NavBarView: View {
    
    @State var tabSelected: Tab = .catalog
    
    var body: some View {
        TabView(selection: $tabSelected) {
            CatalogView()
                .tabItem{
                    Label("Каталог", systemImage: "list.dash")
                        .tag(Tab.catalog)
                }
            CartView()
                .tabItem{
                    Label("Корзина", systemImage: "cart")
                        .tag(Tab.cart)
                }
            AuthView()
                .tabItem{
                    Label("Профиль", systemImage: "gearshape")
                        .tag(Tab.settings)
                }
        }
    }
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView()
    }
}
