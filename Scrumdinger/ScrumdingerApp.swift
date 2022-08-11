//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by User on 7/14/22.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?

    init() {
        #if DEBUG
        var injectionBundlePath = "/Applications/InjectionIII.app/Contents/Resources"
        #if targetEnvironment(macCatalyst)
        injectionBundlePath = "\(injectionBundlePath)/macOSInjection.bundle"
        #elseif os(iOS)
        injectionBundlePath = "\(injectionBundlePath)/iOSInjection.bundle"
        #endif
        Bundle(path: injectionBundlePath)?.load()
        #endif
    }

    @State private var scrums = DailyScrum.sampleData
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $store.scrums) {
                    Task {
                        do {
                            try await ScrumStore.save(scrums: store.scrums)
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                        }
                    }
                }
            }
                    .task {
                        do {
                            store.scrums = try await ScrumStore.load()
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, guidance: "Scrumdigner will load sample data and continue")
                        }
                    }
                    .sheet(item: $errorWrapper, onDismiss: {
                        store.scrums = DailyScrum.sampleData
                    }) { wrapper in
                        ErrorView(errorWrapper: wrapper)
                    }
        }
    }
}
