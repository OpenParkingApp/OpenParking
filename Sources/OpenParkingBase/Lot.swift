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
    public let paymentInfo: PaymentInfo?
    public let openingHours: OpeningHours?
    /// An optional warning not intended to be stored with the lot, but for highlighting possible inconsistencies in static data.
    public let warning: String?
    public let additionalInformation: [String: Any]?

    public init(dataAge: Date?,
                name: String,
                coordinates: Coordinates,
                city: String,
                region: String?,
                address: String?,
                available: Available,
                capacity: Int?,
                state: Lot.State,
                type: Lot.LotType?,
                detailURL: URL?,
                paymentInfo: PaymentInfo?,
                openingHours: OpeningHours?,
                warning: String? = nil,
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
        self.paymentInfo = paymentInfo
        self.openingHours = openingHours
        self.warning = warning
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

    public struct PaymentInfo {
        public let url: URL?
        public let pricing: String?

        public init(url: URL? = nil, pricing: String? = nil) {
            self.url = url
            self.pricing = pricing
        }
    }

    public struct OpeningHours {
        public let url: URL?
        public let times: String?

        public init(url: URL? = nil, times: String? = nil) {
            self.url = url
            self.times = times
        }
    }
}
