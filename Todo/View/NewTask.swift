import SwiftUI

struct NewTask: View {
  @State(initialValue: "") var task
  @State(initialValue: Date()) var time: Date?
  @State(initialValue: false) var isDateShown
  @State var category: Int16
  @Environment(\.managedObjectContext) private var viewContext
  @Environment(\.presentationMode) private var mode

  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("タスク")) {
          TextField("タスクを入力", text: $task)
        }
        datePickerSection

        Picker(selection: $category, label: Text("種類")) {
          ForEach(TodoEntity.Category.allCases, id: \.self) { category in
            HStack {
              CategoryImage(category)
              Text(category.toString())
            }.tag(category.rawValue)
          }
        }

        Section(header: Text("操作")) {
          Button(action: {
            mode.wrappedValue.dismiss()
          }) {
            HStack(alignment: .center) {
              Image(systemName: "minus.circle.fill")
              Text("キャンセル")
            }.foregroundColor(.tRed)
          }.navigationTitle("タスクの追加")
            .navigationBarItems(
              trailing: Button(action: save) {
                Text("保存")
              })
        }
      }
    }
  }

  private var datePickerSection: some View {
    Section(
      header: Toggle(isOn: Binding(isNotNil: $time, defaultValue: Date())) {
        Text("時間を指定する")
      }
    ) {
      HStack {
        if time == nil {
          Text("時間未設定").foregroundColor(.secondary)
        } else {
          Text("日時:")
        }
        Spacer()
        Text(formattedDate())
      }.onTapGesture {
        isDateShown.toggle()
      }
      if isDateShown && time != nil {
        DatePicker("", selection: Binding($time, Date())).labelsHidden()
          .datePickerStyle(WheelDatePickerStyle())
      }
    }
  }

  private func formattedDate() -> String {
    guard let time = time else {
      return ""
    }
    let df = DateFormatter()
    df.locale = Locale(identifier: "js_JP")
    df.dateStyle = .medium
    df.dateFormat = "yyyy/MM/dd hh:mm"
    return df.string(from: time)
  }

  private func save() {
    TodoEntity.create(
      in: viewContext,
      category: TodoEntity.Category(rawValue: category) ?? .ImpUrg_1st,
      task: task, time: time)
    mode.wrappedValue.dismiss()
  }
}

class NewTask_Previews: PreviewProvider {
  static var previews: some View {
    NewTask(category: 0)
  }

  #if DEBUG
    @objc class func injected() {
      (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
        .windows.first?.rootViewController =
        UIHostingController(
          rootView:
            NewTask(category: 0).environment(
              \.managedObjectContext,
              PersistenceController.preview.container.viewContext)
        )
    }
  #endif
}
