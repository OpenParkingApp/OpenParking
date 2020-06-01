import Foundation

private var dateFormatter = DateFormatter()

/// Pre-defined date format values for use with `String.date(withFormat:)`.
public enum DateFormat: String {
    case ddMMyyyy_HHmmss = "dd.MM.yyyy HH:mm:ss"
    case isoDateOnly = "yyyy-MM-dd"
    case isoNoTimezone = "yyyy-MM-dd'T'HH:mm:ss"
    case iso8601 = "yyyy-MM-dd'T'HH:mm:ssZ"
}

public extension String {
    /// Try and parse a date value via the given `DateFormat`.
    func date(withFormat format: DateFormat,
              timezone: TimeZone = TimeZone(identifier: "Europe/Berlin")!) -> Date? {
        date(withFormat: format.rawValue, timezone: timezone)
    }

    /// Try and parse a date value via the given raw date format string.
    func date(withFormat format: String,
              timezone: TimeZone = TimeZone(identifier: "Europe/Berlin")!) -> Date? {
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timezone
        return dateFormatter.date(from: self)
    }
}

public extension Date {
    /// Format a date via the given `DateFormat`.
    func string(withFormat format: DateFormat) -> String {
        string(withFormat: format.rawValue)
    }

    /// Format a date via the given raw date format string.
    func string(withFormat format: String) -> String {
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
