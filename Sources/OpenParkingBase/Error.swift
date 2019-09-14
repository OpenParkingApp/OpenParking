public enum OpenParkingError: Error {
    case decoding(description: String, underlyingError: Error?)
    case network(Error)
    case server(status: Int, response: String)
    case other(Error?)
}

public enum LotError: Error {
    case missingMetadata(lot: String)
    case missingMetadataField(String, lot: String)
    case other(reason: String)
}

public typealias LotResult = Result<Lot, LotError>
