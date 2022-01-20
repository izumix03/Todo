import SwiftUI

struct EditTask: View {
  @ObservedObject var todo: TodoEntity

  @State(initialValue: false) var isDateShown

  @Environment(\.managedObjectContext) private var viewContext
  @Environment(\.presentationMode) private var mode

  var body: some View {
    Form {
      Section(header: Text("タスク")) {
        TextField("タスクを入力", text: Binding($todo.task, "todo"))
      }
      datePickerSection

      Picker(selection: $todo.category, label: Text("種類")) {
        ForEach(TodoEntity.Category.allCases, id: \.self) { category in
          HStack {
            CategoryImage(category)
            Text(category.toString())
          }.tag(category.rawValue)
        }
      }

      Section(header: Text("操作")) {
        Button(action: {
          // TODO
        }) {
          HStack(alignment: .center) {
            Image(systemName: "minus.circle.fill")
            Text("削除")
          }.foregroundColor(.tRed)
        }.navigationTitle("タスクの編集")
          .navigationBarItems(
            trailing: Button(action: save) {
              Text("閉じる")
            })
      }
    }
  }

  private func delete() {
    viewContext.delete(todo)
    save()
  }

  private var datePickerSection: some View {
    Section(
      header: Toggle(isOn: Binding(isNotNil: $todo.time, defaultValue: Date()))
      {
        Text("時間を指定する")
      }
    ) {
      HStack {
        if todo.time == nil {
          Text("時間未設定").foregroundColor(.secondary)
        } else {
          Text("日時:")
        }
        Spacer()
        Text(formattedDate())
      }.onTapGesture {
        isDateShown.toggle()
      }
      if isDateShown && todo.time != nil {
        DatePicker("", selection: Binding($todo.time, Date())).labelsHidden()
          .datePickerStyle(WheelDatePickerStyle())
      }
    }
  }

  private func formattedDate() -> String {
    guard let time = todo.time else {
      return ""
    }
    let df = DateFormatter()
    df.locale = Locale(identifier: "js_JP")
    df.dateStyle = .medium
    df.dateFormat = "yyyy/MM/dd hh:mm"
    return df.string(from: time)
  }

  private func save() {
    try! viewContext.save()
    mode.wrappedValue.dismiss()
  }
}

class EditTask_Previews: PreviewProvider {
  static var vc = PersistenceController.preview.container.viewContext
  static var todo = TodoEntity(context: vc)

  static var previews: some View {
    EditTask(todo: todo)
  }

  #if DEBUG
    @objc class func injected() {
      (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
        .windows.first?.rootViewController =
        UIHostingController(
          rootView:
            NavigationView {
              EditTask(todo: todo)
            }
        )
    }
  #endif
}
