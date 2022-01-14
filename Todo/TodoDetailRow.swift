import SwiftUI

struct TodoDetailRow: View {
  @ObservedObject var todo: TodoEntity

  var body: some View {
    HStack {
      CategoryImage(TodoEntity.Category(rawValue: todo.category))
      CheckBox(
        checked: Binding(
          get: {
            self.todo.state == TodoEntity.State.done.rawValue
          },
          set: {
            self.todo.state =
              $0
              ? TodoEntity.State.done.rawValue : TodoEntity.State.todo.rawValue
          })
      ) {
        if self.todo.state == TodoEntity.State.done.rawValue {
          Text(self.todo.task ?? "no title")
            .strikethrough()
        } else {
          Text(self.todo.task ?? "no title")
        }
      }.foregroundColor(
        self.todo.state == TodoEntity.State.done.rawValue
          ? .secondary : .primary)
    }
  }
}

class TodoDetailRow_Previews: PreviewProvider {
  static var previews: some View {
    TodoDetailRow(todo: TodoEntity.previewData)
  }

  #if DEBUG
    @objc class func injected() {
      (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
        .windows.first?.rootViewController =
        UIHostingController(
          rootView:
            TodoDetailRow(todo: TodoEntity.previewData)
        )
    }
  #endif
}
