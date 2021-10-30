//
//  DividedProgressBar.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/10/30.
//

import SwiftUI

struct DividedProgressBar: View {
    let currentValue: Int // カウントの現在値
    let maxValue: Int // カウントの最大値
    let divideValue: Int // カウントの分割単位

    let separateWidth = CGFloat(5)
    let height = CGFloat(10)
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let maxValue = maxValue <= 0 ? 1 : maxValue
                var divideValue = divideValue <= 0 ? maxValue : divideValue
                var unitCount = Int(maxValue/divideValue)
                let isJust = maxValue % divideValue == 0 ? 0 : 1
                
                // 割り切れない部分の長さ
                var leaveWidth = geometry.size.width / (CGFloat(maxValue) / CGFloat(maxValue % divideValue))
                
                if maxValue % divideValue == 0 {
                    // 割り切れる場合は残り長さを0とする
                    leaveWidth = 0
                } else if leaveWidth < height {
                    // 割り切れない、かつ端数分があまりにも短すぎる場合は点とする
                    leaveWidth = height
                }
                
                var unitWidth = (geometry.size.width - leaveWidth - separateWidth * CGFloat(unitCount + isJust - 1)) / CGFloat(unitCount)
                
                // あまりにも分割しすぎる場合は直線とする
                if unitWidth < height {
                    divideValue = maxValue
                    unitWidth = geometry.size.width
                    unitCount = 1
                }
                
                // 割り切れる部分の描画
                (0..<unitCount).forEach { index in
                    path.addRoundedRect(in: CGRect(x: (unitWidth + separateWidth) * CGFloat(index),
                                                   y: CGFloat(0),
                                                   width: unitWidth,
                                                   height: height),
                                        cornerSize: CGSize(width: height / 2, height: height / 2))
                }
                
                // 割り切れない部分の描画
                if isJust == 1 {
                    path.addRoundedRect(in: CGRect(x: geometry.size.width - leaveWidth,
                                                   y: CGFloat(0),
                                                   width: leaveWidth,
                                                   height: height),
                                        cornerSize: CGSize(width: height / 2, height: height / 2))
                }
            }
            .fill(Color.blue)
        }.frame(maxHeight: height, alignment: .center)
    }
}

struct DividedProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VStack {
                DividedProgressBar(currentValue: 0, maxValue: 120, divideValue: 5)
                DividedProgressBar(currentValue: 0, maxValue: 120, divideValue: 10)
                DividedProgressBar(currentValue: 0, maxValue: 120, divideValue: 20)
                DividedProgressBar(currentValue: 0, maxValue: 120, divideValue: 30)
                DividedProgressBar(currentValue: 0, maxValue: 120, divideValue: 40)
                DividedProgressBar(currentValue: 0, maxValue: 120, divideValue: 50)
                DividedProgressBar(currentValue: 0, maxValue: 120, divideValue: 60)
            }
            Divider()
            VStack {
                DividedProgressBar(currentValue: 0, maxValue: 120, divideValue: 70)
                DividedProgressBar(currentValue: 0, maxValue: 120, divideValue: 80)
                DividedProgressBar(currentValue: 0, maxValue: 120, divideValue: 90)
                DividedProgressBar(currentValue: 0, maxValue: 120, divideValue: 100)
                DividedProgressBar(currentValue: 0, maxValue: 120, divideValue: 110)
                DividedProgressBar(currentValue: 0, maxValue: 120, divideValue: 120)
            }
            Divider()
            Spacer()
        }//.padding()
            .frame(width: 200, height: 500, alignment: .center)
    }
}
