//
// Created by User on 8/11/22.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack {
                Text("An error has occurred!")
                        .font(.title)
                        .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                        .font(.headline)
                Text(errorWrapper.error.localizedDescription)
                        .font(.caption)
                        .padding(.top)
                Spacer()
            }
                    .padding()
                    .background(.ultraThickMaterial)
                    .cornerRadius(16)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Dismiss") {
                                dismiss()
                            }
                        }
                    }
        }
    }
}

class ErrorView_Previews: PreviewProvider {
    enum SampleError: Error {
        case errorRequired
    }

    static var wrapper: ErrorWrapper {
        ErrorWrapper(error: SampleError.errorRequired,
                guidance: "You can safely ignore this error")
    }

    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }

    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController =
                UIHostingController(rootView: ErrorView(errorWrapper: wrapper))
    }
    #endif
}
