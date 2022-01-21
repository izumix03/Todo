//
// Created by mix on 2022/01/06.
//

import SwiftUI

struct QuickNewTask: View {
  let category: TodoEntity.Category
  @State private(set) var newTask = ""
  @Environment(\.managedObjectContext) var viewContext

  var body: some View {
    HStack {
      titleInput
      addButton
    }
  }

  private var titleInput: some View {
    TextField("新しいタスク", text: $newTask, onCommit: addNewTask)
      .textFieldStyle(RoundedBorderTextFieldStyle())
  }

  private var addButton: some View {
    Button(action: addNewTask) {
      Text("追加")
    }
  }

  private func addNewTask() {
    TodoEntity.create(in: viewContext, category: category, task: newTask)
    self.newTask = ""
  }

  private func cancelTask() {
    self.newTask = ""
  }
}

class QuickNewTask_Previews: PreviewProvider {
  static var previews: some View {
    QuickNewTask(category: .NImpUrg_3rd)
  }

  #if DEBUG
    @objc class func injected() {
      (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
        .windows.first?.rootViewController =
        UIHostingController(
          rootView:
            QuickNewTask(category: .NImpUrg_3rd)
            .environment(
              \.managedObjectContext,
              PersistenceController.preview.container.viewContext)
        )
    }
  #endif
}
