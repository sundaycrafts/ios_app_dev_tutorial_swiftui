import SwiftUI

struct ScrumProgressViewStyle: ProgressViewStyle {
    var theme: Theme

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                    .fill(theme.accentColor)
                    .frame(height: 20.0)
            if #available(iOS 15.0, *) {
                ProgressView(configuration)
                        .tint(theme.mainColor)
                        .frame(height: 12.0)
                        .padding(.horizontal)
            } else {
                ProgressView(configuration)
                        .frame(height: 12.0)
                        .padding(.horizontal)
            }
        }
    }
}

class ScrumProgressViewStyle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(value: 0.4)
                .progressViewStyle(ScrumProgressViewStyle(theme: .buttercup))
                .previewLayout(.sizeThatFits)
    }

    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController =
                UIHostingController(rootView:
                ProgressView(value: 0.4)
                        .progressViewStyle(ScrumProgressViewStyle(theme: .buttercup))
                        .previewLayout(.sizeThatFits)
                )
    }
    #endif
}
