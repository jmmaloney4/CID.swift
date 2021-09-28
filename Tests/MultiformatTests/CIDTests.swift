// Copyright © 2021 Jack Maloney. All Rights Reserved.
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import XCTest
@testable import Multiformat

final class CIDTests: XCTestCase {
    let cids = [
        ("QmbWqxBEKC3P8tqsKc98xmWNzrzDtRLMiMPL8wBuTGsMnR", CID.Version.v0, CodecPrefix.dag_pb, "C3C4733EC8AFFD06CF9E9FF50FFC6BCD2EC85A6170004BB709669C31DE94391A"),
        ("QmVEyAvfnwTGNZkygziiwTdR9GQCFhFm9kHUmewmmWGx9p", .v0, .dag_pb, "668D32FAB71AE57D548CADB4AA7A13108B4ABB61D6DB2557B3FAFB079B409263"),
        ("bafkreiglbo2l5lp25vteuexq3svg5hoad76mehz4tlrbwheslvluxcd63a", .v1, .raw, "CB0BB4BEADFAED664A12F0DCAA6E9DC01FFCC21F3C9AE21B1C925D574B887ED8"),
    ]

    func testExample() throws {
        let cid = try CID("bafkreiglbo2l5lp25vteuexq3svg5hoad76mehz4tlrbwheslvluxcd63a")
        XCTAssertEqual(try Multibase(cid.hash.digest, withEncoding: .base16).stringRepresentation(), "cb0bb4beadfaed664a12f0dcaa6e9dc01ffcc21f3c9ae21b1c925d574b887ed8")

        for (c, v, p, h) in self.cids {
            let cid = try CID(c)
            let digest = try Multibase(h.uppercased(), withEncoding: .base16upper).data
            XCTAssertEqual(cid.version, v)
            XCTAssertEqual(cid.codec, p)
            XCTAssertEqual(cid.hash.digest, digest)
            XCTAssertEqual(cid.description, c)
        }
    }
}
