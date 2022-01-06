//
// Created by mix on 2022/01/06.
//

import SwiftUI

struct CategoryImage: View {
    var body: some View {
        Image(systemName: "star.leadinghalf.filled")
                .resizable()
                .scaledToFit()
                .foregroundColor(.yellow)
                .padding(10)
                .frame(width: 200, height: 200)
                .background(Color(.cyan))
                .cornerRadius(30)
    }
}

class CategoryImage_Previews: PreviewProvider {
    static var previews: some View {
        CategoryImage()
    }

    #if DEBUG
    @objc class func injected() {
        (UIApplication.shared.connectedScenes.first
            as? UIWindowScene)?.windows.first?
                .rootViewController =
            UIHostingController(rootView: CategoryImage())
    }
    #endif
}
