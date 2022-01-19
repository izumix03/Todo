//
// Created by mix on 2022/01/06.
//

import SwiftUI

struct CategoryView: View {
  let category: TodoEntity.Category
  @State var numberOfTasks = 0
  @State(initialValue: false) var showList
  @Environment(\.managedObjectContext) var viewContext

  var body: some View {
    VStack(alignment: .leading) {
      categoryImage.font(.largeTitle)
        .sheet(isPresented: $showList) {
          TodoList(category: category)
            .environment(\.managedObjectContext, viewContext)
        }
      categoryTitle
      taskCountText
      newTaskButton
      Spacer()
    }.padding()
      .frame(maxWidth: .infinity, minHeight: 150)
      .foregroundColor(.white)
      .background(category.color())
      .cornerRadius(20)
      .onTapGesture {
        showList = true
      }
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
    Button(action: {}) {
      Image(systemName: "plus")
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
              CategoryView(
                category: .ImpUrg_1st,
                numberOfTasks: 100)
              CategoryView(
                category: .ImpNUrg_2nd,
                numberOfTasks: 100)
              CategoryView(
                category: .NImpUrg_3rd,
                numberOfTasks: 100)
              CategoryView(
                category: .NImpNUrg_4th,
                numberOfTasks: 100)
            }.environment(
                \.managedObjectContext,
                PersistenceController.preview.container.viewContext)
        )
    }
  #endif
}
