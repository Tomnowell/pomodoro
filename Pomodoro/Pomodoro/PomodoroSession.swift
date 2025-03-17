import Foundation
import SwiftData

@Model
class PomodoroSession {
    var duration: Int // Duration in seconds
    var date: Date    // Date of the session
    var completed: Bool
    
    
    init(duration: Int, date: Date = Date(), completed: Bool = true) {
        self.duration = duration
        self.date = date
        self.completed = completed
    }
}
