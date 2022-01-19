import SwiftUI

struct NewTask: View {
  @State(initialValue: "") var task
  @State(initialValue: Date()) var time
  @State(initialValue: false) var isDataShown

  var body: some View {
    NavigationView {
      Form {
        TextField("タスクを入力", text: $task)

        HStack {
          Text("日時:")
          Spacer()
          Text(formattedDate())
        }.onTapGesture {
          withAnimation { isDataShown.toggle() }
        }

        if isDataShown {
          DatePicker("", selection: $time).labelsHidden()
            .datePickerStyle(WheelDatePickerStyle())
        }
        Button(action: {}) {
          HStack(alignment: .center) {
            Image(systemName: "minus.circle.fill")
            Text("キャンセル")
          }.foregroundColor(.tRed)
        }.navigationTitle("タスクの追加")
      }
    }
  }

  private func formattedDate() -> String {
    let df = DateFormatter()
    df.locale = Locale(identifier: "js_JP")
    df.dateStyle = .medium
    df.dateFormat = "yyyy/MM/dd hh:mm"
    return df.string(from: time)
  }
}

class NewTask_Previews: PreviewProvider {
  static var previews: some View {
    NewTask()
  }

  #if DEBUG
    @objc class func injected() {
      (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
        .windows.first?.rootViewController =
        UIHostingController(
          rootView:
            NewTask()
        )
    }
  #endif
}
