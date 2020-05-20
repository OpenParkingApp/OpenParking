public struct Warning {
    public let lotName: String?
    public let source: StaticString
    public let warning: String

    public var textRepr: String {
        if let name = lotName {
            return "⚠️ \(name): \(warning)\n   \(source)"
        } else {
            return "⚠️ \(warning)\n   \(source)"
        }
    }

    static var warnings: [Warning] = []

    public static func flush() -> [Warning] {
        defer { warnings.removeAll() }
        print(warnings.map(\.textRepr).joined(separator: "\n"))
        return warnings
    }
}

/// Send a warning upstream that there is a potential incosistency in the data that should be investigated but was not severe enough to stop data collection for this lot.
public func warning(_ warning: String,
                    lotName: String? = nil,
                    source: StaticString = #file) {
    Warning.warnings.append(Warning(lotName: lotName, source: source, warning: warning))
}
