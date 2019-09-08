public enum OpenParkingError: Error {
    case decoding(description: String, underlyingError: Error?)
    case missingMetadata(lot: String)
    case missingMetadataField(String, lot: String)
    case network(Error)
    case server(status: Int)
    case other(Error?)
}
