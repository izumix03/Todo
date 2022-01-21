//
// Created by mix on 2022/01/21.
//

import Combine
import SwiftUI

class KeyboardObserver: ObservableObject {
  @Published(initialValue: 0.0) private(set) var height: CGFloat

  func startObserve() {
    NotificationCenter
      .default
      .addObserver(
        self,
        selector: #selector(keyboardWillChangeFrame),
        name: UIResponder.keyboardWillChangeFrameNotification,
        object: nil)
  }

  func stopObserve() {
    NotificationCenter.default.removeObserver(
      self,
      name: UIResponder.keyboardWillChangeFrameNotification,
      object: nil
    )
  }

  @objc
  private func keyboardWillChangeFrame(_ notification: Notification) {
    if let endFrame =
      notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
      as? NSValue,
      let beginFrame =
        notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey]
        as? NSValue
    {
      let endMinY = endFrame.cgRectValue.minY
      let beginMinY = beginFrame.cgRectValue.minY
      height = max(beginMinY - endMinY, 0)
    }
  }
}
