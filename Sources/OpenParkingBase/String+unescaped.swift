import HTMLString

public extension String {
    var unescaped: String {
        return self.removingHTMLEntities
    }
}
