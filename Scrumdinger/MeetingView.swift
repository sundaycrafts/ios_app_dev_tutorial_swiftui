//
//  ContentView.swift
//  Scrumdinger
//
//  Created by User on 7/14/22.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false

    private var player: AVPlayer { AVPlayer.sharedDingPlayer }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                    .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                MeetingTimerView(speakers: scrumTimer.speakers, isRecording: isRecording, theme: scrum.theme)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
                .padding()
                .foregroundColor(scrum.theme.accentColor)
                .onAppear {
                    scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
                    scrumTimer.speakerChangedAction = {
                        player.seek(to: .zero)
                        player.play()
                    }
                    speechRecognizer.reset()
                    speechRecognizer.transcribe()
                    isRecording = true
                    scrumTimer.startScrum()
                }
                .onDisappear {
                    scrumTimer.stopScrum()
                    speechRecognizer.stopTranscribing()
                    isRecording = true
                    let newHistory = History(attendees: scrum.attendees, lengthInMinutes: scrum.timer.secondsElapsed / 60, transcript: speechRecognizer.transcript)
                    scrum.history.insert(newHistory, at: 0)
                }
                .navigationBarTitleDisplayMode(.inline)
    }
}

class MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }

    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController =
                UIHostingController(rootView: MeetingView(scrum: .constant(DailyScrum.sampleData[0])))
    }
    #endif
}
