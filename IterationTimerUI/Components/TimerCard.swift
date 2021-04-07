//
//  TimerCard.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/04/07.
//

import SwiftUI

public struct TimerCard: View {
    public init() {}
    public var body: some View {
        HStack(alignment: .top, spacing: 4) {
            CardIcon(systemName: "gamecontroller")
            VStack(alignment: .leading, spacing: 8) {
                Text("SampleTitle")
                    .font(.largeTitle)
                VStack(alignment: .leading, spacing: 4) {
                    ProgressView(value: 0.666)
                    HStack(alignment: .bottom) {
                        Spacer()
                        HStack {
                            Text("10秒")
                                .font(.body)
                            Text("3分20秒")
                                .font(.body)
                            Text("40/60")
                                .font(.body)
                        }
                    }
                }
            }
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct TimerCard_Previews: PreviewProvider {
    static var previews: some View {
        TimerCard()
            .frame(width: nil, height: nil, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding(10)
            .previewLayout(.sizeThatFits)
    }
}
