import SwiftUI

struct TodoDetailRow: View {
  @ObservedObject var todo: TodoEntity
  var hideIcon = false

  var body: some View {
    HStack {
      if !hideIcon {
        CategoryImage(TodoEntity.Category(rawValue: todo.category))
      }
      CheckBox(
        checked: Binding(
          get: {
            self.todo.done()
          },
          set: {
            self.todo.state =
              $0
              ? TodoEntity.State.done.rawValue : TodoEntity.State.todo.rawValue
          })
      ) {
        if self.todo.done() {
          Text(self.todo.task ?? "no title")
            .strikethrough()
        } else {
          Text(self.todo.task ?? "no title")
        }
      }.foregroundColor(
        self.todo.state == TodoEntity.State.done.rawValue
          ? .secondary : .primary)
    }.gesture(
      DragGesture().onChanged { value in
        let distance = value.predictedEndTranslation.width
        if distance > 200 {
          self.todo.complete()
        } else if distance < -200 {
          self.todo.back()
        }
      })
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
            VStack {
              TodoDetailRow(todo: TodoEntity.previewData)
              TodoDetailRow(todo: TodoEntity.previewData, hideIcon: true)
            }
        )
    }
  #endif
}
