import Foundation

public struct Lot {
    public let dataAge: Date?
    public let name: String
    public let coordinates: Coordinates
    public let city: String
    public let region: String?
    public let address: String?
    public let free: FreeCount
    public let total: Int?
    public let state: State
    public let kind: Kind?
    public let detailURL: URL?
    public let additionalInformation: [String: Any]?

    public init(dataAge: Date?,
                name: String,
                coordinates: Coordinates,
                city: String,
                region: String?,
                address: String?,
                free: FreeCount,
                total: Int?,
                state: Lot.State,
                kind: Lot.Kind?,
                detailURL: URL?,
                additionalInformation: [String : Any]? = nil) {
        self.dataAge = dataAge
        self.name = name
        self.coordinates = coordinates
        self.city = city
        self.region = region
        self.address = address
        self.free = free
        self.total = total
        self.state = state
        self.kind = kind
        self.detailURL = detailURL
        self.additionalInformation = additionalInformation
    }
}

extension Lot {
    public enum FreeCount {
        case discrete(Int)
        case range(ClosedRange<Int>)
    }

    public enum State {
        case open, closed, noData
    }

    public enum Kind: String {
        case lot, structure, underground, street
    }
}
