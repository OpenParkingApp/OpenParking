public func warn(_ warning: String,
                 lotName: String? = nil,
                 source: StaticString = #file) {
    if let name = lotName {
        print("⚠️ \(name): \(warning)\n   \(source)")
    } else {
        print("⚠️ \(warning)\n   \(source)")
    }
}
