//
//  CardView.swift
//  meal_selector_swiftUI
//
//  Created by 蔡竣傑 on 2024/4/16.
//

import SwiftUI

struct CardView: View {
    var name:String
    var onSwipe: (() -> Void)?
    @State private var offset = CGSize.zero
    @State private var color = Color.orange
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: 320, height: 420)
                .border(.white, width: 6)
                .cornerRadius(4)
                .foregroundColor(color.opacity(0.9))
            HStack{
                Text(name)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .offset(x: offset.width, y:offset.height * 0.6)
        .rotationEffect(.degrees(offset.width/40.0))
        .gesture(DragGesture()
            .onChanged{gesture in
                offset = gesture.translation
            }.onEnded{_ in
                withAnimation{
                    swipeCard(width: offset.width)
                }
            })
    }
    func swipeCard(width:CGFloat){
        switch width{
        case -500...(-150):
            //offset = CGSize(width: -500, height: 0)
            onSwipe?()
            print("swipe left")
        case 150...500:
            //offset = CGSize(width: 500, height: 0)
            onSwipe?()
            print("swipe right")
        default:
            offset = .zero
        }
    }
}

#Preview {
    CardView(name:"name")
}
