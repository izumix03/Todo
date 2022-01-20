import SwiftUI

struct RoundedCorners: Shape {
  var tl: CGFloat = 0.0
  var tr: CGFloat = 0.0
  var bl: CGFloat = 0.0
  var br: CGFloat = 0.0

  func path(in rect: CGRect) -> Path {
    var path = Path()
    let w = rect.size.width
    let h = rect.size.height

    let tr = min(min(self.tr, h / 2), w / 2)
    let tl = min(min(self.tl, h / 2), w / 2)
    let bl = min(min(self.bl, h / 2), w / 2)
    let br = min(min(self.br, h / 2), w / 2)

    path.move(to: CGPoint(x: w / 2.0, y: 0))
    path.addLine(to: CGPoint(x: w - tr, y: 0))
    path.addArc(
      center: CGPoint(x: w - tr, y: tr), radius: tr,
      startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0),
      clockwise: false)
    path.addLine(to: CGPoint(x: w, y: h - br))
    path.addArc(
      center: CGPoint(x: w - br, y: h - br), radius: br,
      startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90),
      clockwise: false)
    path.addLine(to: CGPoint(x: bl, y: h))
    path.addArc(
      center: CGPoint(x: bl, y: h - bl), radius: br,
      startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180),
      clockwise: false)
    path.addLine(to: CGPoint(x: 0, y: 0 + tr))
    path.addArc(
      center: CGPoint(x: tl, y: tl), radius: tl,
      startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270),
      clockwise: false)
    path.closeSubpath()
    return path
  }

}

class RoundedCorners_Previews: PreviewProvider {
  static var previews: some View {
    RoundedCorners()
  }

  #if DEBUG
    @objc class func injected() {
      (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
        .windows.first?.rootViewController =
        UIHostingController(
          rootView:
            RoundedCorners(
              tl: 30,
              tr: 30,
              bl: 0,
              br: 0
            ).stroke().padding()
        )
    }
  #endif
}