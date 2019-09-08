import Foundation

private var dateFormatter = DateFormatter()

public enum DateFormat: String {
    case ddMMyyyy_HHmmss = "dd.MM.yyyy HH:mm:ss"
    case isoDateOnly = "yyyy-MM-dd"
    case isoNoTimezone = "yyyy-MM-dd'T'HH:mm:ss"
    case iso8601 = "yyyy-MM-dd'T'HH:mm:ssZ"
}

public extension String {
    func date(withFormat format: DateFormat) -> Date? {
        date(withFormat: format.rawValue)
    }

    func date(withFormat format: String) -> Date? {
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}

public extension Date {
    func string(withFormat format: DateFormat) -> String {
        string(withFormat: format.rawValue)
    }

    func string(withFormat format: String) -> String {
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
