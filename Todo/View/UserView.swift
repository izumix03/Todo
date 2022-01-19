//
// Created by mix on 2022/01/06.
//

import SwiftUI

struct UserView: View {
  let profileImage: Image
  let userName: String

  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text("こんにちは")
          .foregroundColor(Color.tTitle)
          .font(.footnote)
        Text(userName)
          .foregroundColor(Color.tTitle)
          .font(.title)
      }
      Spacer()
      profileImage
        .resizable()
        .scaledToFit()
        .frame(width: 60)
        .clipShape(Circle())
    }
    .padding()
    .background(Color.tBackground)
  }
}

class UserView_Previews: PreviewProvider {
  static var previews: some View {
    UserView(profileImage: Image("mix"), userName: "Takahiro Izumikawa")
  }

  #if DEBUG
    @objc class func injected() {
      (UIApplication.shared.connectedScenes.first
        as? UIWindowScene)?.windows.first?
        .rootViewController =
        UIHostingController(
          rootView:
            VStack {
              UserView(profileImage: Image("mix"), userName: "Takahiro Izumikawa")
            })
    }
  #endif
}
