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
  @Environment(\.managedObjectContext) private var viewContext

  var body: some View {
    NavigationView {
      VStack {
        List {
          todoListView
        }
        QuickNewTask(category: category).padding()
      }.navigationTitle(category.toString())
        .navigationBarItems(
          trailing: todoList.isEmpty
            ? AnyView(EmptyView()) : AnyView(EditButton()))
    }.navigationViewStyle(StackNavigationViewStyle())
      .onAppear {
        UIApplication.shared.closeKeyboard()
      }.onDisappear {
        UIApplication.shared.closeKeyboard()
      }
  }

  private var todoListView: some View {
    ForEach(todoList) { todo in
      if category.match(todo.category) {
        NavigationLink(destination: EditTask(todo: todo)) {
          TodoDetailRow(todo: todo, hideIcon: true)
        }
      }
    }.onDelete(perform: deleteTodo)
  }

  private func deleteTodo(at offsets: IndexSet) {
    for index in offsets {
      let entity = todoList[index]
      viewContext.delete(entity)
    }
    try! viewContext.save()
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
