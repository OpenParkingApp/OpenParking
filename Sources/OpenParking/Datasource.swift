import Foundation

public protocol Datasource {
    /// The source's canonical name.
    var name: String { get }

    /// The source's name as a URL-compatible slug.
    var slug: String { get }

    /// URL pointing to a description of the data, not necessarily where the live data is accessed from.
    var infoURL: URL { get }

    /// Attribution data for the contributor of the source.
    var contributor: String? { get }
    /// URL pointing to more information regarding the contribution of the source.
    var attributionURL: URL? { get }
    /// A license under which this source is being published.
    var license: String? { get }

    /// Entrypoint for gathering current data.
    ///
    /// This function can throw errors to indicate that data collection has failed entirely and can not be continued. Please use the `DataPoint`'s `LotResult`
    /// to indicate for failures for specific lots or `warn(_:lotName:)` for indicating issues that do not indicate that data collection has failed.
    func data() throws -> DataPoint
}

public extension Datasource {
    var contributor: String? { return nil }
    var attributionURL: URL? { return nil }
    var license: String? { return nil }
}

public extension Datasource {
    func geodata(from bundle: Bundle,
                 withFilename filename: String = "geojson",
                 andExtension extension: String = "json") throws -> GeoJson {
        guard let geodataURL = bundle.url(forResource: filename, withExtension: `extension`) else {
            throw OpenParkingError.missingGeodata
        }
        return try JSONDecoder().decode(GeoJson.self, from: Data(contentsOf: geodataURL))
    }
}
