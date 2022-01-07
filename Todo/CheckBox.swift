//
// Created by mix on 2022/01/06.
//

import SwiftUI

struct CheckBox<Label: View>: View {
//    @State var checked = false
    @Binding var checked: Bool
    private let label: () -> Label

    public init(checked: Binding<Bool>,
                @ViewBuilder label: @escaping () -> Label) {
        // Binding 構造体へのアクセスは _XXX
        self._checked = checked
        self.label = label
    }

    var body: some View {
        HStack {
            Image(systemName: checked ? "checkmark.circle" : "circle")
                    .onTapGesture {
                        self.checked.toggle()
                    }
            label()
        }
    }
}

class CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        CheckBox(checked: .constant(true)) {
            Text("牛乳を買う")
        }
    }

    #if DEBUG
    @objc class func injected() {
        (UIApplication.shared.connectedScenes.first
            as? UIWindowScene)?.windows.first?
                .rootViewController =
            UIHostingController(rootView:
            VStack {
                CheckBox(checked: .constant(true)) {
                    Text("牛乳を買う2")
                }.padding(20)
                CheckBox(checked: .constant(true)) {
                    Image(systemName: "hand.thumbsup")
                }
            })
    }
    #endif
}
