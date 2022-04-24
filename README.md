# NFTExplorerService

Gets NFT Artworks from a NFTExplorer GRPC Server.

# GRPC uses protoc to get rpc calls.

In swift the command needed to compile from a .proto is:

```bash
protoc nft_explorer.proto \
    --proto_path=. \
    --plugin=/opt/homebrew/Cellar/swift-protobuf/1.18.0_1/bin/protoc-gen-swift \
    --swift_opt=Visibility=Public \
    --swift_out=. \
    --plugin=/opt/homebrew/Cellar/grpc-swift/1.7.0/bin/protoc-gen-grpc-swift \
    --grpc-swift_opt=Client=true,Server=false \
    --grpc-swift_opt=Visibility=Public \
    --grpc-swift_out=. \
```
