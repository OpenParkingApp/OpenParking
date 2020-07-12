import Foundation
@_exported import GeoJSON

public typealias GeoJson = FeatureCollection

public extension FeatureCollection {
    /// Returns the first `Feature` containing `name` as a property.
    func lot(withName name: String) -> Feature? {
        return features.first { $0.properties?.name == name }
    }
}

public extension Feature {
    /// Convenience accessor for `Feature.properties?.name`.
    var name: String? {
        properties?.name
    }

    /// Convert a `String` value from a `Feature`'s properties into a `URL`.
    /// - Parameter name: properties key
    func url(for name: String) -> URL? {
        properties?[name].flatMap { URL(string: $0) }
    }
}

public extension Geometry {
    func center() -> Position {
        switch self {
        case .point(let point):
            return point.coordinates
        case .multiPoint(let multiPoint):
            fatalError("not yet implemented")
        case .lineString(let lineString):
            fatalError("not yet implemented")
        case .multiLineString(let multiLineString):
            fatalError("not yet implemented")
        case .polygon(let polygon):
            fatalError("not yet implemented")
        case .multiPolygon(let multiPolygon):
            fatalError("not yet implemented")
        case .geometryCollection(let geometryCollection):
            fatalError("not yet implemented")
        }
    }
}
