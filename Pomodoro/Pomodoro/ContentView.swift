//
//  ContentView.swift
//  Pomodoro
//
//  Created by Tom on 2025/03/13.
//

import SwiftUI
import SwiftData
import UserNotifications

struct ContentView: View {
    @State private var timeRemaining = 1500
    @State private var timerActive: Bool = false
    @State private var timer: Timer?

    var body: some View {
        VStack(spacing: 40) {
            // Timer display text
            Text(formatTime(timeRemaining)).font(.system(size: 96))
            
            // Primary Start Button
            Button(action: startTimer) {
                Text(timerActive ? "Running..." : "Start")
                    .frame(width: 200, height: 50)
                    .background(timerActive ? Color.gray : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(timerActive) // Disable while running
            
            // Secondary Controls
            HStack(spacing: 20) {
                Button("Pause") {
                    pauseTimer()
                }
                .frame(width: 100, height: 44)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(12)
                .disabled(!timerActive) // Only enable when running
                
                Button("Reset") {
                    resetTimer()
                }
                .frame(width: 100, height: 44)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
    }
    .padding()
        
}

    // Helper to format seconds into mm:ss
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
    
    private func startTimer() {
        timerActive = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                timerActive = false
                notifyTimerFinished()
            }
        }
    }
    
    private func pauseTimer() {
        timer?.invalidate()
        timerActive = false
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timerActive = false
        timeRemaining = 1500
    }
    
    func notifyTimerFinished() {
        let content = UNMutableNotificationContent()
        content.title = "🍅 Pomodoro Finished!"
        content.body = "Nice job! Time for a short break."
        content.sound = UNNotificationSound.default

        // Immediate notification
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification scheduling error: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
}


