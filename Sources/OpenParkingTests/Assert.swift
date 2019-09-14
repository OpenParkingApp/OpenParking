import XCTest
import OpenParkingBase

public func assert(datasource: Datasource,
                   ignoreExceededCapacity: Bool = false,
                   file: StaticString = #file,
                   line: UInt = #line) {
    do {
        let data = try datasource.data()
        XCTAssert(!data.lots.isEmpty, file: file, line: line)

        for lot in data.lots {
            assert(lot: lot, ignoreExceededCapacity: ignoreExceededCapacity, file: file, line: line)
        }
    } catch {
        XCTFail("Fetching data from \(datasource.name) failed with: \(error)", file: file, line: line)
    }
}

public func assert(lot: LotResult,
                   ignoreExceededCapacity: Bool = false,
                   file: StaticString = #file,
                   line: UInt = #line) {
    switch lot {
    case .failure(let error):
        switch error {
        case .missingMetadata(lot: let lot):
            XCTFail("Missing metadata for \(lot)", file: file, line: line)
        case .missingMetadataField(let field, lot: let lot):
            XCTFail("\(lot) metadata missing expected field \(field)", file: file, line: line)
        }
    case .success(let lot):
        if let dataAge = lot.dataAge {
            XCTAssert(dataAge < Date(), "\(lot) data age should be in the past.", file: file, line: line)
        }
        XCTAssert(!lot.name.isEmpty, "Lot name should not be empty", file: file, line: line)
        XCTAssert(!lot.city.isEmpty, "\(lot) city should not be empty", file: file, line: line)
        if let region = lot.region {
            XCTAssert(!region.isEmpty, "\(lot) region should not be empty if set", file: file, line: line)
        }
        if let address = lot.address {
            XCTAssert(!address.isEmpty, "\(lot) address should not be empty if set", file: file, line: line)
        }
        if !ignoreExceededCapacity {
            switch lot.available {
            case .discrete(let available):
                XCTAssert(available >= 0, "\(lot) should have a positive amount of available spots", file: file, line: line)
                if let capacity = lot.capacity {
                    XCTAssert(available <= capacity, "\(lot) available spots should not exceed the capacity", file: file, line: line)
                }
            case .range(let range):
                XCTAssert(range.lowerBound >= 0, "\(lot) availability range should start at a positive value", file: file, line: line)
                if let capacity = lot.capacity {
                    XCTAssert(range.upperBound <= capacity, "\(lot) availability range upper bound should not exceed the capacity", file: file, line: line)
                }
            }
        }
    }
}
