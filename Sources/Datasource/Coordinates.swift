/// A set of WGS84 coordinates used to specify a location.
public struct Coordinates {
    public let latitude: Double
    public let longitude: Double

    public init(lat: Double, lng: Double) {
        self.latitude = lat
        self.longitude = lng
    }
}
