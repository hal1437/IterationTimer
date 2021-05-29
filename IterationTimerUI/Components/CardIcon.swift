//
//  CardIcon.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/04/07.
//

import SwiftUI

struct CardIcon: View {
    let category: TimerCategory
    var body: some View {
        Image(uiImage: category.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30, alignment: .center)
            .padding(8)
            .background(Color.gray)
            .clipShape(Circle())
    }
}

struct CardIcon_Previews: PreviewProvider {
    static var previews: some View {
        CardIcon(category: .game)
            .previewLayout(.sizeThatFits)
    }
}
