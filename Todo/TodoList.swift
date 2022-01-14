//
// Created by mix on 2022/01/06.
//

import CoreData
import SwiftUI

struct TodoList: View {
  @FetchRequest(
    sortDescriptors: [
      NSSortDescriptor(keyPath: \TodoEntity.time, ascending: true)
    ], animation: .default)
  var todoList: FetchedResults<TodoEntity>
  let category: TodoEntity.Category

  var body: some View {
    VStack {
      List {
        ForEach(todoList) { todo in
          if todo.category == self.category.rawValue {
            TodoDetailRow(todo: todo, hideIcon: true)
          }
        }
      }
      QuickNewTask(category: category)
        .padding()
    }
  }
}

class TodoList_Previews: PreviewProvider {
  static var previews: some View {
    TodoList(category: .NImpUrg_3rd)
      .environment(
        \.managedObjectContext,
        PersistenceController.preview.container.viewContext)
  }

  #if DEBUG
    @objc class func injected() {
      (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
        .windows.first?.rootViewController =
        UIHostingController(
          rootView:
            TodoList(category: .NImpUrg_3rd)
            .environment(
              \.managedObjectContext,
              PersistenceController.preview.container.viewContext)
        )
    }
  #endif
}
