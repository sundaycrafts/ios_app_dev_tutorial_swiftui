//
//  ThemeView.swift
//  Scrumdinger
//
//  Created by User on 7/24/22.
//

import SwiftUI

struct ThemeView: View {
    let theme: Theme

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                    .fill(theme.mainColor)
            Label(theme.name, systemImage: "paintpalette")
                    .padding(4)
        }
                .foregroundColor(theme.accentColor)
                .fixedSize(horizontal: false, vertical: true)
    }
}

class ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(theme: .buttercup)
    }

    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController =
                UIHostingController(rootView: ThemeView(theme: .buttercup))
    }
    #endif
}
