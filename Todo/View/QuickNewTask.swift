//
// Created by mix on 2022/01/06.
//

import SwiftUI

struct QuickNewTask: View {
  let category: TodoEntity.Category
  @State private(set) var newTask = ""

  var body: some View {
    HStack {
      titleInput
      addButton
      cancelButton
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

  private var cancelButton: some View {
    Button(action: cancelTask) {
      Text("キャンセル")
        .foregroundColor(.red)
    }
  }

  private func addNewTask() {
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
        )
    }
  #endif
}