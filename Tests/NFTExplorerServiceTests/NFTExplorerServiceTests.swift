    import XCTest
    @testable import NFTExplorerService

    final class NFTExplorerServiceTests: XCTestCase {
        var knownArtworkName = ProcessInfo.processInfo.environment["TESTING_ARTWORK_NAME"]
        var testingAccount = ProcessInfo.processInfo.environment["ETH_TESTING_ACCOUNT"]
        var testingGRPCHost = ProcessInfo.processInfo.environment["TESTING_GRPC_HOST"]
        var testingGRPCPort = Int(ProcessInfo.processInfo.environment["TESTING_GRPC_PORT"] ?? "50005")
        
        
        func testListArtworksStream() async throws {
            let service = BaseNFTExplorerService(host: testingGRPCHost!, port: testingGRPCPort!)
            
            var hasKnownArtwork = false
            
            do {
                for try await artwork in service.streamOwnedArworks(of: testingAccount!, timeoutMilis: 3000) {
                    XCTAssertNotNil(artwork)
                    print(artwork)
                    if artwork.name == knownArtworkName! {
                        hasKnownArtwork = true
                    }
                }
            } catch let error {
                print("NFT Explorer Service test failed with error \(error)")
                XCTFail()
            }
            
            if !hasKnownArtwork {
                print("NFT Explorer Service testing account \(testingAccount!) doesnt has known artwork of name \(knownArtworkName!)")
                XCTFail()
            }
        }
    }
