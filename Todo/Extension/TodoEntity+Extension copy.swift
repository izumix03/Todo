//
// Created by mix on 2022/01/07.
//

import SwiftUI
import CoreData

extension TodoEntity {
  enum Category {
    case ImpUrg_1st
    case ImpNUrg_2nd
    case NImpUrg_3rd
    case NImpNUrg_4th

    func toString() -> String {
      switch self {
      case .ImpUrg_1st:
        return "重要かつ緊急"
      case .ImpNUrg_2nd:
        return "重要だが緊急ではない"
      case .NImpUrg_3rd:
        return "重要でないが緊急"
      case .NImpNUrg_4th:
        return "重要でも緊急でもない"
      }
    }

    func image() -> String {
      switch self {
      case .ImpUrg_1st:
        return "flame"
      case .ImpNUrg_2nd:
        return "tortoise.fill"
      case .NImpUrg_3rd:
        return "alarm"
      case .NImpNUrg_4th:
        return "tv.music.note"
      }
    }

    func color() -> Color {
      switch self {
      case .ImpUrg_1st:
        return .tRed
      case .ImpNUrg_2nd:
        return .tBlue
      case .NImpUrg_3rd:
        return .tGreen
      case .NImpNUrg_4th:
        return .tYellow
      }
    }
  }

  enum State: Int16 {
    case todo
    case done
  }
}
