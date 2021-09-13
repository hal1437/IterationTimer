//
//  TimeInterval+Format.swift
//  IterationTimerUI
//
//  Created by hal1437 on 2021/04/10.
//

import Foundation

public extension TimeInterval {
    
    /// DateComponentsFormatterを使って適切な文字列に変換する
    func toFormatString() -> String {
        // ロケール用のカレンダーを準備する
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ja_JP")

        let formatter = DateComponentsFormatter()
        formatter.calendar = calendar
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        formatter.zeroFormattingBehavior = [.dropLeading]

        return formatter.string(from: self)!
    }
}
