//
//  DividedProgressBar.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/10/30.
//

import SwiftUI

struct DividedProgressBar: View {
    private let currentValue: Int // カウントの現在値
    private let maxValue: Int // カウントの最大値
    private let divideValue: Int // カウントの分割単位

    init(currentValue: Int, maxValue: Int, divideValue: Int) {
        self.currentValue = min(currentValue, maxValue)
        self.maxValue = max(maxValue, 1)
        self.divideValue = divideValue <= 0 ? maxValue : divideValue
    }
    
    var body: some View {
        GeometryReader { geometry in
            let property = makeGraphProperty(geometry)

            property.barPath.fill(Color.gray)
            property.barPath.fill(Color.blue).mask(property.maskPath)
        }.frame(maxHeight: CGFloat(10), alignment: .center)
    }
    
    struct GraphProperty {
        let currentValue: Int // カウントの現在値
        let maxValue: Int // カウントの最大値
        let divideValue: Int // カウントの分割単位
        let width: CGFloat // 全体幅

        let separateWidth = CGFloat(5)
        let height = CGFloat(10)

        // 割り切れる部分の...
        var unitDivideCount: Int { return maxValue / divideValue } // 本数
        var competeUnitDivideCount: Int { return currentValue / divideValue } // 満たされている本数
        var unitWidth: CGFloat { return (width - leaveWidth - separateWidth * CGFloat(unitDivideCount - (isJust ? 1 : 0))) / CGFloat(unitDivideCount) }
        
        // 割り切れない部分の...
        var leaveCount: Int { return maxValue % divideValue } // 値換算値
        var leaveCurrentCount: Int { return currentValue - unitDivideCount * divideValue }
        var leaveWidth: CGFloat { return isJust ? 0 : max(width * CGFloat(leaveCount) / CGFloat(maxValue), height) } // 長さ換算値
        
        var isJust: Bool { return maxValue % divideValue == 0 } // 割り切れるかどうか
        
        var barPath: Path {
            return Path { path in
                // 割り切れる部分の描画
                (0 ..< unitDivideCount).forEach { index in
                    path.addRoundedRect(in: CGRect(x: (unitWidth + separateWidth) * CGFloat(index),
                                                   y: CGFloat(0),
                                                   width: unitWidth,
                                                   height: height),
                                        cornerSize: CGSize(width: height / 2, height: height / 2))
                }
                
                // 割り切れない部分の描画
                if !isJust {
                    path.addRoundedRect(in: CGRect(x: (unitWidth + separateWidth) * CGFloat(unitDivideCount),
                                                   y: CGFloat(0),
                                                   width: leaveWidth,
                                                   height: height),
                                        cornerSize: CGSize(width: height / 2, height: height / 2))
                }
            }
        }
        
        var maskPath: Path {
            // 枠組みの描画
            return Path { path in
                var width = CGFloat(0)
    
                // ゲージが完成している分の進行度
                width += (unitWidth + separateWidth) * CGFloat(competeUnitDivideCount)
    
                if currentValue < divideValue * unitDivideCount {
                    // ゲージが分割区間内で途中の場合
                    width += unitWidth * (CGFloat(currentValue % divideValue) / CGFloat(divideValue))
                } else {
                    // ゲージが分割区間外で途中の場合
                    width += leaveWidth * (CGFloat(leaveCurrentCount) / CGFloat(leaveCount))
                }

                path.addRect(CGRect(x: 0,
                                    y: CGFloat(0),
                                    width: width,
                                    height: height))
            }
        }
    }
        
    private func makeGraphProperty(_ geometry: GeometryProxy) -> GraphProperty {
        let sample = GraphProperty(currentValue: self.currentValue,
                                   maxValue: self.maxValue,
                                   divideValue: self.divideValue,
                                   width: geometry.size.width)

        // あまりにも分割しすぎる場合は直線とする
        if sample.unitWidth < sample.height {
            return GraphProperty(currentValue: self.currentValue,
                                 maxValue: self.maxValue,
                                 divideValue: self.maxValue,
                                 width: geometry.size.width)
        } else {
            return sample
        }
    }
}

struct DividedProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VStack {
                DividedProgressBar(currentValue: 100, maxValue: 120, divideValue: 1)
                DividedProgressBar(currentValue: 100, maxValue: 120, divideValue: 5)
                DividedProgressBar(currentValue: 100, maxValue: 120, divideValue: 10)
                DividedProgressBar(currentValue: 100, maxValue: 120, divideValue: 20)
                DividedProgressBar(currentValue: 100, maxValue: 120, divideValue: 30)
                DividedProgressBar(currentValue: 100, maxValue: 120, divideValue: 40)
                DividedProgressBar(currentValue: 100, maxValue: 120, divideValue: 50)
                DividedProgressBar(currentValue: 100, maxValue: 120, divideValue: 60)
            }
            Divider()
            VStack {
                DividedProgressBar(currentValue: 100, maxValue: 120, divideValue: 70)
                DividedProgressBar(currentValue: 100, maxValue: 120, divideValue: 80)
                DividedProgressBar(currentValue: 100, maxValue: 120, divideValue: 90)
                DividedProgressBar(currentValue: 100, maxValue: 120, divideValue: 100)
                DividedProgressBar(currentValue: 100, maxValue: 120, divideValue: 110)
                DividedProgressBar(currentValue: 100, maxValue: 120, divideValue: 119)
                DividedProgressBar(currentValue: 100, maxValue: 120, divideValue: 120)
            }
            Divider()
            Spacer()
        }.padding()
//            .frame(width: 200, height: 700, alignment: .center)
    }
}
