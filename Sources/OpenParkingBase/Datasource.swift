import Foundation

public protocol Datasource {
    /// The source's canonical name.
    var name: String { get }

    /// The source's name as a URL-compatible slug.
    var slug: String { get }

    /// URL pointing to a description of the data, not necessarily where the live data is accessed from.
    var infoUrl: URL { get }

    /// Attribution data for the contributor of the source.
    var contributor: String? { get }
    /// URL pointing to more information regarding the contribution of the source.
    var attributionURL: URL? { get }
    /// A license under which this source is being published.
    var license: String? { get }

    /// The function responsible for fetching all necessary data and generating a current data point.
    func data() throws -> DataPoint
}

public extension Datasource {
    var contributor: String? { return nil }
    var attributionURL: URL? { return nil }
    var license: String? { return nil }
}
