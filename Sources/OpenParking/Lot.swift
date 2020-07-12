import Foundation
import GeoJSON

/// A place where cars can be left to do whatever cars do when no one's around.
public struct Lot {
    /// The time when this data was last updated according to the source.
    public let dataAge: Date?
    /// Name of the lot.
    public let name: String
    /// A physical location, ideally the center point of the lot. Is used to display a marker on maps.
    public let position: Position?
    /// The geometric shape of the lot, if known. Could be a `LineString` for a streetside lot, a `Polygon` for a typical lot or something more complex.
    /// Please make sure to at least set the lot's `position`, not just the `geometry`.
    public let geometry: Geometry?
    /// The city or town this lot resides in.
    public let city: String
    /// An optional region or district, if applicable.
    public let region: String?
    /// A street address, if applicable.
    public let address: String?
    /// The count of empty spots available for use. Can either be a discrete value or a range.
    public let available: Available
    /// The total capacity if available.
    public let capacity: Int?
    /// The current state of the lot, e.g. is it open for access?
    public let state: State
    /// The lot's type, maybe it's not a lot at all, but an underground carpark?
    public let type: LotType?
    /// An optional detail URL pointing to more info on this lot.
    public let detailURL: URL?
    /// An optional image URL.
    public let imageURL: URL?
    /// Pricing information, can contain a direct description and/or a URL pointing to more information or payment options.
    public let pricing: Pricing?
    /// Hours of operation, can contain a direct description and/or a URL pointing to more information.
    public let openingHours: OpeningHours?
    /// Any additional information that could be relevant, possibly an entrance height?
    public let additionalInformation: [String: Any]?

    public init(dataAge: Date? = nil,
                name: String,
                position: Position?,
                geometry: Geometry?,
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
        self.position = position
        self.geometry = geometry
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
        // basic public types
        case lot, structure, underground, street
        // special
        case bus, camper
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
