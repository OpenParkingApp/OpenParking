import Foundation

public struct DataPoint {
    public let dateDownloaded: Date
    public let lots: [LotResult]

    public init(dateDownloaded: Date = Date(), lots: [LotResult]) {
        self.dateDownloaded = dateDownloaded
        self.lots = lots
    }
}
