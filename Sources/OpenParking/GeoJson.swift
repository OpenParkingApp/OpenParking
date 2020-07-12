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

    /// Convenience accessor for `Feature.properties?.address`.
    var address: String? {
        properties?.address
    }

    /// Convenience accessor for `Feature.properties?.type`.
    var type: Lot.LotType? {
        properties?.type.flatMap { Lot.LotType(rawValue: $0) }
    }

    /// Convert a `String` value from a `Feature`'s properties into a `URL`.
    /// - Parameter key: properties key
    func url(for key: String) -> URL? {
        properties?[key].flatMap { URL(string: $0) }
    }
}

public extension Geometry {
    func center() -> Position {
        switch self {
        case .point(let point):
            return point.coordinates
        case .multiPoint(_):
            fatalError("not yet implemented")
        case .lineString(_):
            fatalError("not yet implemented")
        case .multiLineString(_):
            fatalError("not yet implemented")
        case .polygon(_):
            fatalError("not yet implemented")
        case .multiPolygon(_):
            fatalError("not yet implemented")
        case .geometryCollection(_):
            fatalError("not yet implemented")
        }
    }
}
