//
//  TodoApp.swift
//  TodoApp
//
//  Created by mix on 2022/01/05.
//
//

import SwiftUI

@main
struct TodoApp: App {
  init() {
    #if DEBUG
      var injectionBundlePath =
        "/Applications/InjectionIII.app/Contents/Resources"
      #if targetEnvironment(macCatalyst)
        injectionBundlePath =
          "\(injectionBundlePath)/macOSInjection.bundle"
      #elseif os(iOS)
        injectionBundlePath =
          "\(injectionBundlePath)/iOSInjection.bundle"
      #endif
      Bundle(path: injectionBundlePath)?.load()
    #endif
  }

  let persistenceController = PersistenceController.shared

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
