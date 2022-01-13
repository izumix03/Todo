//
// Created by mix on 2022/01/06.
//

import SwiftUI

struct CategoryView: View {
  let category: TodoEntity.Category
  @State var numberOfTasks = 0
  var body: some View {
    VStack(alignment: .leading) {
      Image(systemName: category.image())
        .font(.largeTitle)
      Text(category.toString())
      Text("・\(numberOfTasks)タスク")
      Button(action: {}) {
        Image(systemName: "plus")
      }
      Spacer()
    }.padding()
      .frame(maxWidth: .infinity, minHeight: 150)
      .foregroundColor(.white)
      .background(category.color())
      .cornerRadius(20)
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
            }
        )
    }
  #endif
}
