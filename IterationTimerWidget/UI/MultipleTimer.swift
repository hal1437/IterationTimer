//
//  MultipleTimer.swift
//  IterationTimerWidget
//
//  Created by hal1437 on 2021/06/10.
//

import SwiftUI
import WidgetKit
import IterationTimerModel
import IterationTimerUI

struct MultipleTimer: View {
    @Environment(\.widgetFamily) var family
    @ObservedObject var viewModel: MultipleTimerViewModel
    private let spacing = CGFloat(8)
    
    init(repository: IterationTimerRepositoryProtocol) {
        self.viewModel = .init(repository: repository)
    }
    
    var body: some View {
        if viewModel.timers.isEmpty {
            Text("WidgetTimerNotFound")
                .minimumScaleFactor(0.5)
                .font(.caption)
                .foregroundColor(.gray)
        } else {
            GeometryReader { geometry in
                LazyVGrid(columns: Array(repeating: GridItem(), count: family.contents.columns), spacing: spacing) {
                    ForEach(viewModel.timers.prefix(family.contents.rows * family.contents.columns)) { timer in
                        let height = CGFloat((Int(geometry.size.height) - Int(spacing) * (family.contents.rows - 1)) / family.contents.rows)
                        
                        Link(destination: URL(string: "com.hal1437.IterationTimer://?id=\(timer.id)")!, label: {
                            InstantTimer(drawable: InstantDrawable(timer: timer, date: Date()))
                        })
                    }
                    Spacer()
                }
            }
            .padding(10)
        }
    }
}

struct MultipleTimer_Previews: PreviewProvider {
    static let previewFamily: [WidgetFamily] = [.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge]
    static var previews: some View {
        Group {
            MultipleTimer(repository: EmptyMockTimerRepository())
                .previewContext(WidgetPreviewContext(family: .systemMedium))

            ForEach(previewFamily, id: \.self) { family in
                Group {
                    MultipleTimer(repository: MockTimerRepository())
                }
                .previewContext(WidgetPreviewContext(family: family))
                .environment(\.colorScheme, .light)

                Group {
                    MultipleTimer(repository: MockTimerRepository())
                }
                .previewContext(WidgetPreviewContext(family: family))
                .environment(\.colorScheme, .dark)
            }
        }
    }
}

private extension WidgetFamily {
    var contents: (rows: Int, columns: Int) {
        switch self {
        case .systemSmall: return (2, 1)
        case .systemMedium: return (2, 2)
        case .systemLarge: return (5, 2)
        case .systemExtraLarge:  return (4, 4)
        @unknown default:
            return (2, 1)
        }
    }
}
