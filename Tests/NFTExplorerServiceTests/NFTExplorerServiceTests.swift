    import XCTest
    @testable import NFTExplorerService

    final class NFTExplorerServiceTests: XCTestCase {
        // TODO: Check the known artwork.
        // Will i need an account? .env?
        
        var knownArtworkName = ""
        var testingAccount = ""
        
        func testGettingEnvironmentVariables() {
            
            XCTAssertEqual(testingAccount, "someaccount")
        }
        /*
        func testListArtworksStream() async throws {
            let service = BaseNFTExplorerService(host: "localhost", port: 50005)
            
            var hasKnownArtwork = false
            
            do {
                for try await artwork in service.streamOwnedArworks(of: testingAccount, timeoutMilis: 3000) {
                    XCTAssertNotNil(artwork)
                    if artwork.Name == knownArtworkName {
                        hasKnownArtwork = true
                    }
                }
            } catch let error {
                print("NFT Explorer Service test failed with error \(error)")
                XCTFail()
            }
            
            if !hasKnownArtwork {
                print("NFT Explorer Service testing account \(testingAccount) doesnt has known artwork of name \(knownArtworkName)")
                XCTFail()
            }
        }
        */
    }
