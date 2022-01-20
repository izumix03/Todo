import SwiftUI

struct TaskToday: View {
  @FetchRequest(
    sortDescriptors: [
      NSSortDescriptor(
        keyPath: \TodoEntity.time,
        ascending: true)
    ],
    predicate: NSPredicate(
      format: "time BETWEEN {%@, %@}",
      Date.today as NSDate,
      Date.tomorrow as NSDate
    ), animation: .default)
  var todoList: FetchedResults<TodoEntity>

  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      Text("今日のタスク").font(.footnote).bold().padding()
      List(todoList) { todo in
        TodoDetailRow(todo: todo)
      }
    }.background(Color(UIColor.systemBackground))
      .clipShape(RoundedCorners(tl: 30,
          tr: 30,
          bl: 0,
          br: 0))
  }
}

class TaskToday_Previews: PreviewProvider {
  static var previews: some View {
    TaskToday().environment(
      \.managedObjectContext,
      PersistenceController.preview.container.viewContext)
  }

  #if DEBUG
    @objc class func injected() {
      (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
        .windows.first?.rootViewController =
        UIHostingController(
          rootView:
            TaskToday()
            .environment(
              \.managedObjectContext,
              PersistenceController.preview.container.viewContext)
        )
    }
  #endif
}
