
import Foundation

public extension Date {
    
    // MARK: - Simple Date Calculations
    func dateByAdding(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }
    
    func offset(from date: Date) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        let endDate = Date()
        return (formatter.string(from: date, to: endDate) ?? "") + " ago"
    }
    
    // MARK: - Components
    var calendar: Calendar {
        var cal = Calendar.current
        cal.timeZone = TimeZone(abbreviation: "GMT") ?? .current
        return cal
    }
    
    var era: Int { calendar.component(.era, from: self) }
    var year: Int { calendar.component(.year, from: self) }
    var month: Int { calendar.component(.month, from: self) }
    var day: Int { calendar.component(.day, from: self) }
    var hour: Int { calendar.component(.hour, from: self) }
    var minute: Int { calendar.component(.minute, from: self) }
    var second: Int { calendar.component(.second, from: self) }
    var nanosecond: Int { calendar.component(.nanosecond, from: self) }
    var weekday: Int { calendar.component(.weekday, from: self) }
    var quarter: Int { calendar.component(.quarter, from: self) }
    var weekOfYear: Int { calendar.component(.weekOfYear, from: self) }
    var weekOfMonth: Int { calendar.component(.weekOfMonth, from: self) }
    
    // MARK: - Checks
    var isInFuture: Bool { self > Date() }
    var isInPast: Bool { self < Date() }
    var isInToday: Bool { calendar.isDateInToday(self) }
    
    // MARK: - ISO & Timestamp
    var iso8601String: String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        return formatter.string(from: self)
    }
    
    var unixTimestamp: Double { timeIntervalSince1970 }
    var millisecondsSince1970: Int64 { Int64((timeIntervalSince1970 * 1000).rounded()) }
    
    // MARK: - Nearest Rounded Time
    private func rounded(minuteInterval: Int) -> Date {
        var comps = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        guard let minute = comps.minute else { return self }
        let remainder = minute % minuteInterval
        comps.minute! = remainder < minuteInterval / 2 ? minute - remainder : minute + (minuteInterval - remainder)
        comps.second = 0
        return calendar.date(from: comps) ?? self
    }
    
    var nearestFiveMinutes: Date { rounded(minuteInterval: 5) }
    var nearestTenMinutes: Date { rounded(minuteInterval: 10) }
    var nearestHalfHour: Date { rounded(minuteInterval: 30) }
    var nearestHourQuarter: Date { rounded(minuteInterval: 15) }
    
    var timeZone: TimeZone { calendar.timeZone }
    
    // MARK: - Add / Change Components
    mutating func add(_ component: Calendar.Component, value: Int) {
        self = calendar.date(byAdding: component, value: value, to: self) ?? self
    }
    
    func adding(_ component: Calendar.Component, value: Int) -> Date {
        return calendar.date(byAdding: component, value: value, to: self) ?? self
    }
    
    func changing(_ component: Calendar.Component, value: Int) -> Date {
        var date = self
        switch component {
        case .second: date = calendar.date(bySetting: .second, value: value, of: self) ?? self
        case .minute: date = calendar.date(bySetting: .minute, value: value, of: self) ?? self
        case .hour: date = calendar.date(bySetting: .hour, value: value, of: self) ?? self
        case .day: date = calendar.date(bySetting: .day, value: value, of: self) ?? self
        case .month: date = calendar.date(bySetting: .month, value: value, of: self) ?? self
        case .year: date = calendar.date(bySetting: .year, value: value, of: self) ?? self
        default: break
        }
        return date
    }
    
    func beginning(of component: Calendar.Component) -> Date? {
        switch component {
        case .second: return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self))
        case .minute: return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self))
        case .hour: return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour], from: self))
        case .day: return calendar.startOfDay(for: self)
        case .weekOfMonth, .weekOfYear:
            return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
        case .month: return calendar.date(from: calendar.dateComponents([.year, .month], from: self))
        case .year: return calendar.date(from: calendar.dateComponents([.year], from: self))
        default: return nil
        }
    }
    
    func end(of component: Calendar.Component) -> Date? {
        guard let start = beginning(of: component) else { return nil }
        switch component {
        case .second: return start.adding(.second, value: 1).adding(.second, value: -1)
        case .minute: return start.adding(.minute, value: 1).adding(.second, value: -1)
        case .hour: return start.adding(.hour, value: 1).adding(.second, value: -1)
        case .day: return calendar.date(byAdding: .day, value: 1, to: start)?.adding(.second, value: -1)
        case .weekOfMonth, .weekOfYear: return calendar.date(byAdding: .day, value: 7, to: start)?.adding(.second, value: -1)
        case .month: return calendar.date(byAdding: .month, value: 1, to: start)?.adding(.second, value: -1)
        case .year: return calendar.date(byAdding: .year, value: 1, to: start)?.adding(.second, value: -1)
        default: return nil
        }
    }
    
    // MARK: - String Formatting
    func dateString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    
    func dateString(ofFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func dateTimeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = style
        return formatter.string(from: self)
    }
    
    func timeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = style
        return formatter.string(from: self)
    }
    
    func isInCurrent(_ component: Calendar.Component) -> Bool {
        switch component {
        case .day: return calendar.isDateInToday(self)
        case .weekOfMonth, .weekOfYear:
            guard let start = Date().beginning(of: .weekOfMonth), let end = Date().end(of: .weekOfMonth) else { return false }
            return self >= start && self <= end
        case .month: return month == Date().month && year == Date().year
        case .year: return year == Date().year
        default: return false
        }
    }
    
    // MARK: - Random Dates
    static func randomWithinDaysBeforeToday(_ days: Int) -> Date {
        let today = Date()
        let dayOffset = Int.random(in: 0..<days)
        let hourOffset = Int.random(in: 0..<24)
        let minuteOffset = Int.random(in: 0..<60)
        let secondOffset = Int.random(in: 0..<60)
        var components = DateComponents()
        components.day = -dayOffset
        components.hour = hourOffset
        components.minute = minuteOffset
        components.second = secondOffset
        return Calendar.current.date(byAdding: components, to: today) ?? today
    }
    
    static func random() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(UInt32.random(in: 0...UInt32.max)))
    }
    
    init(milliseconds: Int64) {
        self.init(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    init(iso8601String: String) {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        self = formatter.date(from: iso8601String) ?? Date()
    }
    
    init(unixTimestamp: Double) {
        self.init(timeIntervalSince1970: unixTimestamp)
    }
}

// MARK: - DateFormatter helper for DOB
extension DateFormatter {
    static let dobFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}


