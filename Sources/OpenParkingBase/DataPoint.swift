import Foundation

public struct DataPoint {
    public let dateDownloaded: Date
    public let lots: [Lot]

    public init(dateDownloaded: Date = Date(), lots: [Lot]) {
        self.dateDownloaded = dateDownloaded
        self.lots = lots
    }
}
