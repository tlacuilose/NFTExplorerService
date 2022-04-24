import GRPC
import Combine
import NIOCore

public protocol NFTExplorerService {
    func streamOwnedArworks(of account: String, timeoutMilis: Int64) -> AsyncThrowingStream<NftExplorerProto_Artwork, Error>
}

public struct BaseNFTExplorerService: NFTExplorerService {
    
    let host: String
    let port: Int
    
    public init(host: String, port: Int) {
        self.host = host
        self.port = port
    }
    
    public func streamOwnedArworks(of account: String, timeoutMilis: Int64) -> AsyncThrowingStream<NftExplorerProto_Artwork, Error> {
        AsyncThrowingStream { continuation in
            Task {
                do {
                    let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
                    defer {
                        try? group.syncShutdownGracefully()
                    }
                    
                    let channel = try GRPCChannelPool.with(
                        target: .host(host, port: port),
                        transportSecurity: .plaintext,
                        eventLoopGroup: group
                    )
                    
                    let client = NftExplorerProto_NFTExplorerClient(channel: channel)
                    
                    let account: NftExplorerProto_Account = .with {
                        $0.address = account
                    }
                    
                    let callOptions = CallOptions(timeLimit: TimeLimit.timeout(TimeAmount.milliseconds(timeoutMilis)))
                    
                    let call = client.listOwnedArtworks(account, callOptions: callOptions) { artwork in
                        continuation.yield(artwork)
                    }
                    
                    let callResponse = try call.status.wait()
                    if (callResponse.isOk) {
                        continuation.finish()
                    } else {
                        if let message = callResponse.message, message.starts(with: "Timed out") {
                            continuation.finish(throwing: NFTCallError(reason: message, kind: .timedOut))
                        } else {
                            continuation.finish(throwing: NFTCallError(reason: callResponse.message, kind: .streamFailed))
                        }
                    }
                } catch let error {
                    continuation.finish(throwing: NFTCallError(reason: error.localizedDescription, kind: .connectionFailed))
                }
            }
        }
        
    }
}

