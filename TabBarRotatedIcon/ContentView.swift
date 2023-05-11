//
//  ContentView.swift
//  TabBarRotatedIcon
//
//  Created by Max Franz Immelmann on 5/11/23.
//

import SwiftUI

struct RotatedTabBar: View {
    let items: [TabBarItem]
    @Binding var selection: Int
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(items.indices) { index in
                items[index].view.tag(index)
            }
        }
        .overlay(
            VStack {
                Spacer()
                HStack(spacing: 0) {
                    ForEach(items.indices) { index in
                        let isSelected = selection == index
                        let item = items[index]
                        TabBarItemView(
                            image: item.image,
                            text: item.text,
                            isSelected: isSelected,
                            onTap: { selection = index }
                        )
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: 50)
                .background(Color.white)
                .cornerRadius(25)
                .shadow(radius: 10)
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        )
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TabBarItemView: View {
    let image: Image
    let text: String
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 5) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .rotationEffect(.degrees(isSelected ? -90 : 90))
                Text(text)
                    .font(.caption)
                    .foregroundColor(isSelected ? .blue : .gray)
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 15)
        }
    }
}

struct TabBarItem: Identifiable {
    let id: Int
    let image: Image
    let text: String
    let view: AnyView
    
    init<Content: View>(id: Int, image: Image, text: String, @ViewBuilder view: () -> Content) {
        self.id = id
        self.image = image
        self.text = text
        self.view = AnyView(view())
    }
}

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        RotatedTabBar(
            items: [
                TabBarItem(id: 0, image: Image(systemName: "house"), text: "Home") {
                    Text("First Tab")
                },
                TabBarItem(id: 1, image: Image(systemName: "person.crop.circle"), text: "Profile") {
                    Text("Second Tab")
                },
            ],
            selection: $selection
        )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
