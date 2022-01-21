import SwiftUI

struct TodoDetailRow: View {
  @ObservedObject var todo: TodoEntity
  var hideIcon = false

  var body: some View {
    HStack {
      categoryImage
      checkbox.foregroundColor(todo.done() ? .secondary : .primary)
    }.gesture(
      DragGesture().onChanged { value in
        let distance = value.predictedEndTranslation.width
        if distance > 200 {
          todo.complete()
        } else if distance < -200 {
          todo.complete(false)
        }
      })
  }

  private var categoryImage: some View {
    hideIcon
      ? AnyView(EmptyView())
      : AnyView(CategoryImage(TodoEntity.Category(rawValue: todo.category)))
  }

  private var checkbox: some View {
    CheckBox(
      checked: Binding(
        get: {
          todo.done()
        },
        set: {
          todo.complete($0)
        })
    ) {
      todo.done()
        ? Text(todo.task ?? "no title").strikethrough()
        : Text(todo.task ?? "no title")
    }
  }
}

class TodoDetailRow_Previews: PreviewProvider {
  static var previews: some View {
    TodoDetailRow(
      todo: TodoEntity.buildSample(
        PersistenceController.preview.container.viewContext))
  }

  #if DEBUG
    @objc class func injected() {
      (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
        .windows.first?.rootViewController =
        UIHostingController(
          rootView:
            VStack {
              TodoDetailRow(
                todo: TodoEntity.buildSample(
                  PersistenceController.preview.container.viewContext))
              TodoDetailRow(
                todo: TodoEntity.buildSample(
                  PersistenceController.preview.container.viewContext),
                hideIcon: true)
            }
        )
    }
  #endif
}
