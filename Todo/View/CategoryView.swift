//
// Created by mix on 2022/01/06.
//

import SwiftUI

struct CategoryView: View {
  let category: TodoEntity.Category
  @State var numberOfTasks = 0

  @State(initialValue: false) private var showList
  @State(initialValue: false) private var addNewTask
  @Environment(\.managedObjectContext) private var viewContext

  var body: some View {
    let gradiant = Gradient(colors: [
      category.color(),
      category.color().opacity(0.0),
    ])
    let linear = LinearGradient(
      gradient: gradiant,
      startPoint: .top,
      endPoint: .bottom)

    return VStack(alignment: .leading) {
      HStack {
        categoryImage.font(.largeTitle)
          .sheet(isPresented: $showList, onDismiss: updateCnt) {
            TodoList(category: category)
          }
        Spacer()
        newTaskButton
      }
      categoryTitle.foregroundColor(.white)
      taskCountText.foregroundColor(.white)
      Spacer()
    }.padding()
      .frame(maxWidth: .infinity, minHeight: 150)
      .background(linear)
      .cornerRadius(20)
      .onTapGesture {
        showList = true
      }.onAppear {
        updateCnt()
      }
  }

  private func updateCnt() {
    numberOfTasks = TodoEntity.count(in: viewContext, category: category)
  }

  private var categoryImage: some View {
    Image(systemName: category.image())
  }

  private var categoryTitle: some View {
    Text(category.toString())
  }

  private var taskCountText: some View {
    Text("・\(numberOfTasks)タスク")
  }

  private var newTaskButton: some View {
    Button(action: {
      addNewTask = true
    }) {
      Text("追加")
        .font(.caption2)
        .padding()
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 3, x: 5, y: 5)
    }.sheet(isPresented: $addNewTask, onDismiss: updateCnt) {
      NewTask(category: category.rawValue)
    }
  }
}

class CategoryView_Previews: PreviewProvider {
  static var previews: some View {
    CategoryView(category: .ImpNUrg_2nd, numberOfTasks: 30)
  }

  #if DEBUG
    @objc class func injected() {
      (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
        .windows.first?.rootViewController =
        UIHostingController(
          rootView:
            VStack {
              HStack {
                CategoryView(
                  category: .ImpUrg_1st,
                  numberOfTasks: 100)
                CategoryView(
                  category: .ImpNUrg_2nd,
                  numberOfTasks: 100)
              }
              HStack {
                CategoryView(
                  category: .NImpUrg_3rd,
                  numberOfTasks: 100)
                CategoryView(
                  category: .NImpNUrg_4th,
                  numberOfTasks: 100)
              }
            }.frame(height: 400).environment(
              \.managedObjectContext,
              PersistenceController.contextWithSample)
        )
    }
  #endif
}
