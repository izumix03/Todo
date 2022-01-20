//
// Created by mix on 2022/01/20.
//

import Foundation

extension Date {
  static var today: Date {
    Calendar(identifier: .gregorian).startOfDay(for: Date())
  }

  static var tomorrow: Date {
    Calendar(identifier: .gregorian).date(
      byAdding: DateComponents(day: 1), to: Date.today)!
  }
}
