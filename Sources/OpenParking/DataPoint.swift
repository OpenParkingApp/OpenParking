import Foundation

/// A collection of lot data point that were collected together.
public struct DataPoint {
    /// Date when this data point was created.
    public let timestamp: Date
    public let lots: [LotResult]

    public init(timestamp: Date = Date(), lots: [LotResult]) {
        self.timestamp = timestamp
        self.lots = lots
    }
}
