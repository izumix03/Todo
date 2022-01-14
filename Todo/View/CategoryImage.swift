//
// Created by mix on 2022/01/06.
//

import SwiftUI

struct CategoryImage: View {
  let category: TodoEntity.Category

  init(_ category: TodoEntity.Category?) {
    self.category = category ?? .ImpUrg_1st
  }

  var body: some View {
    Image(systemName: category.image())
      .resizable()
      .scaledToFit()
      .foregroundColor(.white)
      .padding(2)
      .frame(width: 30, height: 30)
      .background(category.color())
      .cornerRadius(6)
  }
}

class CategoryImage_Previews: PreviewProvider {
  static var previews: some View {
    CategoryImage(TodoEntity.Category.ImpUrg_1st)
  }

  #if DEBUG
    @objc class func injected() {
      (UIApplication.shared.connectedScenes.first
        as? UIWindowScene)?.windows.first?
        .rootViewController =
        UIHostingController(rootView: CategoryImage(TodoEntity.Category.ImpUrg_1st))
    }
  #endif
}
