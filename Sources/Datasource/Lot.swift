import Foundation

public struct Lot {
    public let dataAge: Date?
    public let name: String
    public let coordinates: Coordinates
    public let city: String
    public let region: String?
    public let address: String?
    public let available: Available
    public let capacity: Int?
    public let state: State
    public let type: LotType?
    public let detailURL: URL?
    public let imageURL: URL?
    public let pricing: Pricing?
    public let openingHours: OpeningHours?
    public let additionalInformation: [String: Any]?

    public init(dataAge: Date? = nil,
                name: String,
                coordinates: Coordinates,
                city: String,
                region: String? = nil,
                address: String? = nil,
                available: Available,
                capacity: Int? = nil,
                state: Lot.State,
                type: Lot.LotType? = nil,
                detailURL: URL? = nil,
                imageURL: URL? = nil,
                pricing: Pricing? = nil,
                openingHours: OpeningHours? = nil,
                additionalInformation: [String : Any]? = nil) {
        self.dataAge = dataAge
        self.name = name
        self.coordinates = coordinates
        self.city = city
        self.region = region
        self.address = address
        self.available = available
        self.capacity = capacity
        self.state = state
        self.type = type
        self.detailURL = detailURL
        self.imageURL = imageURL
        self.pricing = pricing
        self.openingHours = openingHours
        self.additionalInformation = additionalInformation
    }
}

extension Lot {
    public enum Available {
        case discrete(Int)
        case range(ClosedRange<Int>)
    }

    public enum State {
        case open, closed, noData
    }

    public enum LotType: String {
        case lot, structure, underground, street
    }

    public struct Pricing {
        public let url: URL?
        public let description: String?

        public init(url: URL) {
            self.url = url
            self.description = nil
        }

        public init(description: String) {
            self.url = nil
            self.description = description
        }

        public init(url: URL, pricing: String) {
            self.url = url
            self.description = pricing
        }
    }

    public struct OpeningHours {
        public let url: URL?
        public let times: String?

        public init(url: URL) {
            self.url = url
            self.times = nil
        }

        public init(times: String) {
            self.url = nil
            self.times = times
        }

        public init(url: URL, times: String) {
            self.url = url
            self.times = times
        }
    }
}
