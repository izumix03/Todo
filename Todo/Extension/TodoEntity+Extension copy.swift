//
// Created by mix on 2022/01/07.
//

import SwiftUI
import CoreData

extension TodoEntity {
  static func create(in managedObjectContext: NSManagedObjectContext,
                     category: Category,
                     task: String,
                     time: Date? = Date()){
    let todo = self.init(context: managedObjectContext)
    print(task)
    todo.time = time
    todo.category = category.rawValue
    todo.task = task
    todo.state = State.todo.rawValue
    todo.id = UUID().uuidString

    do {
      try managedObjectContext.save()
    } catch {
      let nserror = error as NSError
      fatalError("unresolved error \(nserror), \(nserror.userInfo)")
    }
  }

  static var previewData: TodoEntity {
    let context = PersistenceController.preview.container.viewContext
    let newTodo = TodoEntity(context: context)
    newTodo.task = "将来の人間関係づくり"
    newTodo.state = TodoEntity.State.allCases.randomElement()!.rawValue
    newTodo.category = TodoEntity.Category.allCases.randomElement()!.rawValue
    return newTodo
  }

  func done() -> Bool {
    self.state == TodoEntity.State.done.rawValue
  }

  func complete(_ ok: Bool = true) {
    if ok {
      if (self.state == TodoEntity.State.todo.rawValue) {
        self.state = TodoEntity.State.done.rawValue
      }
    } else {
      if (self.state == TodoEntity.State.done.rawValue) {
        self.state = TodoEntity.State.todo.rawValue
      }
    }
  }

  enum Category: Int16, CaseIterable {
    case ImpUrg_1st
    case ImpNUrg_2nd
    case NImpUrg_3rd
    case NImpNUrg_4th

    func match(_ category: Int16) -> Bool {
      self.rawValue == category
    }

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

  enum State: Int16, CaseIterable {
    case todo
    case done
  }
}
