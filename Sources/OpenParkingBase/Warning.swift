public func warn(_ warning: String,
                 lotName: String? = nil,
                 lotCity: String? = nil) {
    switch (lotName, lotCity) {
    case let (.some(name), .some(city)):
        print("⚠️ \(name) \(city): \(warning)")
    case let (.some(name), _):
        print("⚠️ \(name): \(warning)")
    case (_, _):
        print("⚠️ \(warning)")
    }
}
