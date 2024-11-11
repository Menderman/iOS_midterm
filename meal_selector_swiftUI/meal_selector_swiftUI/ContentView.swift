//
//  ContentView.swift
//  meal_selector_swiftUI
//
//  Created by 蔡竣傑 on 2024/4/16.
//

import SwiftUI

struct Item:Identifiable,Equatable{
    var id = UUID()
    var name:String
}

struct ContentView: View {
    @State private var meal_items = [Item(name:"等等吃什麼"),Item(name:"咖哩飯"), Item(name:"炒麵"), Item(name:"義大利麵")]
    @State private var items = [Item(name:"等等吃什麼"), Item(name:"咖哩飯"), Item(name:"炒麵"), Item(name:"義大利麵")]
    @State private var showConfigSheet: Bool = false
    @State private var isCap: Bool = false
    //@State private var selectedItem = Set<UUID>()
    
    @State private var itemName = ""
    
    private var isNotValid: Bool{
        itemName == ""
    }
    
    var body: some View{
        Spacer()
            ZStack{
                ForEach(items.reversed(), id: \.id){ item in
                    CardView(name: item.name){
                        swipeItem(item)
                    }
                }
            }
            .padding()
        
        Spacer()
        
        HStack(
            alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,spacing: 100, content: {
            Button("打亂選項"){
                items=meal_items
                for i in 1..<(items.count) {
                    let randomIndex = Int.random(in: i..<items.count)
                    if i != randomIndex {
                        items.swapAt(i, randomIndex)
                    }
                }
            }
            .buttonStyle(.bordered)
            .tint(.red)
            
            Button("設定"){
                showConfigSheet.toggle()
            }
            .buttonStyle(.bordered)
            .tint(.red)
                
            .sheet(isPresented: $showConfigSheet) {
                NavigationView{
                    Form{
//                        Section("Setting"){
//                            Toggle("Captitalized", isOn: $isCap)
//                        }
                        
                        Section("我的選項"){
                            //EditButton()
                            List($meal_items, editActions: .all) { $meal_item in
                                TextField("Item name",text: $meal_item.name)
                            }
                        }
                        Section("新增選項"){
                            TextField("輸入名稱", text: $itemName)
                            Button("新增") {
                                meal_items.append(Item(name:itemName))
                                items.append(Item(name:itemName))
                            }
                            .disabled(isNotValid)
                        }
                    }
                    .navigationTitle(Text("設定選項"))
                }
            }
        })
    }
    private func swipeItem(_ item: Item) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}
