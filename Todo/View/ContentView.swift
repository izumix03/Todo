//
//  ContentView.swift
//  Todo
//
//  Created by mix on 2022/01/05.
//
//

import SwiftUI

struct ContentView: View {

  var body: some View {
    VStack(spacing: 0) {
      // 塗りつぶし
      Color.tBackground.edgesIgnoringSafeArea(.top).frame(height: 0)
      UserView(profileImage: Image("mix"), userName: "Takahiro Izumikawa")
      VStack(spacing: 0) {
        HStack(spacing: 0) {
          CategoryView(category: .ImpUrg_1st)
          Spacer()
          CategoryView(category: .ImpNUrg_2nd)
        }
        Spacer()
        HStack(spacing: 0) {
          CategoryView(category: .NImpUrg_3rd)
          Spacer()
          CategoryView(category: .NImpNUrg_4th)
        }
      }.padding()

      TaskToday()
    }.background(Color.tBackground)
      .edgesIgnoringSafeArea(.bottom)

  }
}

class ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }

  #if DEBUG
    @objc class func injected() {
      (UIApplication.shared.connectedScenes.first
        as? UIWindowScene)?.windows.first?
        .rootViewController =
        UIHostingController(
          rootView: ContentView().environment(
            \.managedObjectContext,
            PersistenceController.contextWithSample)
        )
    }
  #endif
}
