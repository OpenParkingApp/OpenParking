import Foundation

/// A single point of data that was created at a specific point in time.
public struct DataPoint {
    /// Date when this data point was created.
    public let timestamp: Date
    public let lots: [LotResult]

    public init(timestamp: Date = Date(), lots: [LotResult]) {
        self.timestamp = timestamp
        self.lots = lots
    }
}
