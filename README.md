# OpenParking

![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/OpenParkingApp/OpenParking)

This package contains necessary types and useful functions for creating data sources for use with the OpenParking project, a service focussed on collecting data on available public parking spots and providing them and derived information as open-data wherever possible.

Check out the [documentation](https://openparkingapp.github.io/OpenParking/) for API specifics.

## Creating a New Data Source

Data sources are Swift packages, one or more per package. Check out [swift.org](https://swift.org) for instructions on how to get Swift running on your system if it's not already set up.

#### Basic Setup

Let's create a new data source for the fictional city of Bielefeld.

```shell
$ mkdir Bielefeld & cd Bielefeld
$ swift package init
```

Now open your newly created package manifest (`Package.swift`) and add OpenParking to your list of dependencies, replacing `latest` with the latest release version listed above. 

```swift
// ...
dependencies: [
    .package(url: "https://github.com/OpenParkingApp/OpenParking.git", from: "latest"),
]
// ...
```

Swift also requires that you add the relevant products to your targets as dependencies. OpenParking contains two targets, OpenParking and OpenParkingTestSupport, the latter containing some helpers to validate your data in your test target. The targets section in our manifest now looks like the following. The dependency of OpenParkingTestSupport on BielefeldTests unfortunately requires you to be a bit more verbose, since it differs from the package basename.

```swift
// ...
targets: [
    .target(
        name: "Bielefeld",
        dependencies: ["OpenParking"]),
    .testTarget(
        name: "BielefeldTests",
        dependencies: [
            .product(name: "OpenParkingTestSupport", package: "OpenParking"),
            "Bielefeld"
        ]),
]
// ...
```

#### Adding the Data Source

Now let's head over into the main implementation in Sources/Bielefeld/Bielefeld.swift. This is where we'll define the actual data source and how it fetches its data.

To start out we're going to import OpenParking, create a new type and conform it to the `Datasource` protocol. Don't forget to mark the type as public so it's accessible from outside of this module.

```swift
import Foundation
import OpenParking

public class Bielefeld: Datasource {
  
}
```

At this point your editor will likely be complaining that `Bielefeld` isn't conforming to `Datasource` since it requires a few attributes. These are:

- name
- slug
- infoURL
- contributor (*optional*)
- attributionURL (*optional*)
- license (*optional*)

Additionally the protocol requires that we implement the function `func data() throws -> DataPoint`, which is the entry point for users of this data source to fetch current data.

Implementing the required attributes and a placeholder for `data()` leaves us with the following. Don't forget to also add a public initializer to your type so it can be created elsewhere.

```swift
public class Bielefeld: Datasource {
    public let name = "Bielefeld"
    public let slug = "bielefeld"
    public let infoURL = URL(string: "https://bielefeld.de")!
  
    public init() {}
  
    public func data() throws -> DataPoint {
        fatalError("not yet implemented")
    }
}
```

#### Adding Tests

Before continuing with the actual implementation of `data()`, let's quickly just add the few lines of code necessary for testing our implementation later. This is done in Tests/BielefeldTests/BielefeldTests.swift. Modify that file to look like this:

```swift
import XCTest
import OpenParkingTestSupport
import Bielefeld

final class BielefeldTests: XCTestCase {
    func testDatasource() throws {
        validate(datasource: Bielefeld())
    }
}
```

That's it! `validate(datasource:)` is a function from OpenParkingTestSupport that fetches live data and runs some validations to check if it makes sense.

You can run the tests via `$ swift test`, you'll see any warnings and errors it encounters.

#### Implementing the Data Source

This is the interesting part and unfortunately also the one that differs for pretty much every data source. There are however some helpful utilities in the OpenParking package to make this a little easier and maintainable.

For ease of use there's two synchronous networking functions,  `get(url:headers:)` and `post(url:headers:)` both of which return a tuple of type `(Data, HTTPURLResponse)`. 

Additionally there's a few helpful extensions on `String` for parsing dates and unescaping HTML entities.

The main idea is to fetch current data and process that to return a `DataPoint` containing information on `Lot`s. For details it probably makes sense to have a look at existing data sources, e.g. [Basel](https://github.com/OpenParkingApp/Basel) or [Herrenberg](https://github.com/OpenParkingApp/Herrenberg).

One more thing to note here are the three available options of indicating issues with the data.

- If there's an inconsistency with the data that should be investigated, but is not a problem, call the `warn(_:lotName:)` function. These warnings will be aggregated and (hopefully) looked at later by whoever's running the data import.
- A `DataPoint` is not a direct collection of `Lot`s, but contains values of type `Result<Lot, LotError>`. Use the `LotError` to highlight if data for a specific lot is broken and can not be aggregated, possibly due to missing static metadata or something else.
- If all else fails and data collection has failed entirely, make use of the throwing nature of `data()` and throw a fitting error.

All of this and more should be listed in the project's [documentation](https://openparkingapp.github.io/OpenParking/) as well.

#### Handling Static Data

*For the time being this is still a TODO as it will be improved with Swift 5.3's upcoming resource handling. In the meantime feel free to have a look at the `GeoJson` type and how it's currently being used in other data sources.*
