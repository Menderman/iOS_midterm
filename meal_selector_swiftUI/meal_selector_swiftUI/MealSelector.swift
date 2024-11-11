//
//  MealSelector.swift
//  meal_selector_swiftUI
//
//  Created by 蔡竣傑 on 2024/4/16.
//

import Foundation

class MealSelector{
    //var meal_list: Array<Card> = Array()
    var meal_list = ["item1", "item2", "item3", "item4", "item5", "item6", "item7", "item8", "item9", "item10"]
    var index = -1
    
//    init(){
//        let names = ["item1", "item2", "item3", "item4", "item5", "item6", "item7", "item8", "item9", "item10"]
//        for item in names{
//            meal_list.append(Card(name:item))
//        }
//    }
    
    func nextItem(){
        index = (index+1)%meal_list.count
    }
    
    func shuffle(){
        for i in meal_list.indices{
            let randomIndex = arc4random_uniform(UInt32(meal_list.count))
            let tmp = meal_list[i]
            meal_list[i] = meal_list[Int(randomIndex)]
            meal_list[Int(randomIndex)] = tmp
        }
    }
    
//    func toggleCard(index:Int){
//        meal_list[index].isEnable = !meal_list[index].isEnable
//    }
}

struct Card:Hashable{
    var isEnable = true
    var id:Int
    let str:String
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(name:String){
        str = name
        id = Card.getUniqueIdentifier()
    }
    
    var hashValue: String{
        get {return str}
    }
    static func ==(lhs: Card, rhs:Card)->Bool{
        return lhs.str==rhs.str
    }
}
