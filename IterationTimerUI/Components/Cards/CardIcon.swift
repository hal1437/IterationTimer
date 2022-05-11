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
        ZStack {
            Circle()
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundColor(.tertiarySystemBackground)

            Image(systemName: category.systemName)
                .resizable()
                .scaledToFit()
                .frame(width: 25.0, height: 25.0)
                .foregroundColor(.primary)
        }
    }
}

struct CardIcon_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardIcon(category: .game)
                .background(Color.secondarySystemBackground)

            CardIcon(category: .game)
                .background(Color.secondarySystemBackground)
                .environment(\.colorScheme, .dark)
        }
        .previewLayout(.sizeThatFits)

    }
}
