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
        todoListView
      }
      QuickNewTask(category: category).padding()
    }
  }

  private var todoListView: some View {
    ForEach(todoList) { todo in
      if category.match(todo.category) {
        TodoDetailRow(todo: todo, hideIcon: true)
      }
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
            TodoList(category: .ImpUrg_1st)
            .environment(
              \.managedObjectContext,
              PersistenceController.preview.container.viewContext)
        )
    }
  #endif
}
