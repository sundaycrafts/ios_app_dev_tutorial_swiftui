//
//  ContentView.swift
//  Scrumdinger
//
//  Created by User on 7/14/22.
//

import SwiftUI

struct MeetingView: View {
    var body: some View {
        VStack {
            ProgressView(value: 5, total: 15)
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elasped")
                            .font(.caption)
                    Label("300", systemImage: "hourglass.bottomhalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                            .font(.caption)
                    Label("600", systemImage: "hourglass.bottomhalf.fill")
                }
            }
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("Time remaining")
                    .accessibilityValue("10 minites")
            Circle()
                    .strokeBorder(lineWidth: 24)
            HStack {
                Text("Seaker 1 of 3")
                Spacer()
                Button(action: {}) {
                    Image(systemName: "forward.fill")
                }
                        .accessibilityLabel("Next speaker")
            }
        }
                .padding()
    }
}

class MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView()
    }

    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController =
                UIHostingController(rootView: MeetingView())
    }
    #endif
}
