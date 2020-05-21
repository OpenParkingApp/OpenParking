import Foundation
import AnyCodable

public struct GeoJson: Decodable {
    public let type: String
    public let features: [Feature]

    @dynamicMemberLookup
    public struct Feature: Decodable {
        public let type: String
        public let geometry: Geometry

        public struct Geometry: Decodable {
            public let type: String
            public let coordinates: [Double]
        }

        public let properties: [String: AnyDecodable]

        public var name: String {
            properties["name"]!.value as! String
        }

        public var coordinates: Coordinates? {
            guard geometry.coordinates.count == 2 else { return nil }
            return Coordinates(lat: geometry.coordinates[0], lng: geometry.coordinates[1])
        }

        public subscript<T>(_ key: String) -> T? {
            get {
                properties[key]?.value as? T
            }
        }

        public subscript<T>(dynamicMember dynamicMember: String) -> T? {
            self[dynamicMember]
        }

        /// Extract a value for a given key from lot metadata.
        /// - Throws: `LotError.missingMetadataField` if no such key exists.
        public func value<T>(for key: String) throws -> T {
            guard let value: T = self[key] else {
                throw LotError.missingMetadataField(key, lot: name)
            }
            return value
        }

        /// Extract a URL for a given key from lot metadata.
        /// - Throws: `LotError.missingMetadataField` if no such key exists.
        /// - Returns: `URL` or `nil` if the value was malformed.
        public func urlValue(for key: String) throws -> URL? {
            guard let value: String = self[key] else {
                throw LotError.missingMetadataField(key, lot: name)
            }
            return URL(string: value)
        }
    }

    public func lot(withName name: String) -> Feature? {
        assert(features.allSatisfy { $0.properties["name"] != nil }, "Every lot feature should have a name property.")
        return features.first { $0.name == name }
    }
}
