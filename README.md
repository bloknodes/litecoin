# litecoin
Litecoin on Docker

## Usage

This will run a litecoin full node on docker and by default it will be running on the testnet.

## Configuration

The configuration file is located in `configs/*.conf` and the network can be set using the environment variable `NETWORK`.

Networks:
- `NETWORK=testnet` - Runs on the testnet and listens on `tcp/19332`.
- `NETWORK=mainnet` - Runs on the mainnet and listens on `tcp/9332`.

Persistence:
- The container uses the path `/blockchain` inside the container and by default the `docker-compose.yaml` creates a docker volume to persist the data.

## Container Images

The container image uses a base image which is available:
- https://github.com/bloknodes/base-nodes

The final images:

- [bloknodes/litecoin:latest](https://hub.docker.com/r/bloknodes/litecoin)
- [bloknodes/litecoin:0.21.2.1](https://hub.docker.com/r/bloknodes/litecoin)

## JSON RPC Examples

<details>
  <summary>List of a couple of example calls that can be used with curl</summary>
  
- `getblockchaininfo`

```bash
curl -u "bloknodes:bloknodes" -d '{"jsonrpc": "1.0", "id": "curl", "method": "getblockchaininfo", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:19332/ 
```

- `listwallets`

```bash
curl -u "bloknodes:bloknodes" -d '{"jsonrpc": "1.0", "id": "curl", "method": "listwallets", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:19332/
```

- `createwallet`

```bash
curl -u "bloknodes:bloknodes" -d '{"jsonrpc": "1.0", "id": "curl", "method": "createwallet", "params": ["test-wallet"]}' -H 'content-type: text/plain;' http://127.0.0.1:19332/
```

- `getwalletinfo`

```bash
curl -u "bloknodes:bloknodes" -d '{"jsonrpc": "1.0", "id": "curl", "method": "getwalletinfo", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:19332/wallet/test-wallet
```

- `getnewaddress`

```bash
curl -u "bloknodes:bloknodes" -d '{"jsonrpc": "1.0", "id": "curl", "method": "getnewaddress", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:19332/wallet/test-wallet
```

- `getaddressesbylabel`

```bash
curl -u "bloknodes:bloknodes" -d '{"jsonrpc": "1.0", "id": "curl", "method": "getaddressesbylabel","params": [""]}' -H 'content-type: text/plain;' http://127.0.0.1:19332/wallet/test-wallet
```

- `getaddressinfo`

```bash
curl -u "bloknodes:bloknodes" -d '{"jsonrpc": "1.0", "id": "curl", "method": "getaddressinfo", "params": ["_address_"]}' -H 'content-type: text/plain;' http://127.0.0.1:19332/wallet/test-wallet
```

- `getbalance`

```bash
curl -u "bloknodes:bloknodes" -d '{"jsonrpc": "1.0", "id": "curl", "method": "getbalance", "params": ["*", 6]}' -H 'content-type: text/plain;’' http://127.0.0.1:19332/wallet/test-wallet
```

- `getbalances`

```bash
curl -u "bloknodes:bloknodes" -d '{"jsonrpc": "1.0", "id": "curl", "method": "getbalances", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:19332/wallet/test-wallet
```

- `listtransactions`

```bash
curl -u "bloknodes:bloknodes" -d '{"jsonrpc": "1.0", "id": "curl", "method": "listtransactions", "params": ["*"]}' -H 'content-type: text/plain;' http://127.0.0.1:19332/wallet/test-wallet
```

- `sendtoaddress`

```bash
curl -u "bloknodes:bloknodes" -d '{"jsonrpc": "1.0", "id": "curl", "method": "sendtoaddress", "params":["_to_address_", 0.01]}' -H 'content-type: text/plain;' http://127.0.0.1:19332/wallet/wallet
```

To see if a node is out of sync, you can look at blocks vs headers in `getblockchaininfo` but to see how long its out of sync:

```bash
median=$(curl -s -u "bloknodes:bloknodes" -d '{"jsonrpc": "1.0", "id": "curl", "method": "getblockchaininfo", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:19332/ | jq -r '.result.mediantime')
seconds=$(echo $(date +%s) - $median | bc )
echo $((seconds/86400))" days "$(date -d "1970-01-01 + $seconds seconds" "+%H hours %M minutes %S seconds")
1525 days 10 hours 41 minutes 27 seconds
```

To view the latest blockinfo:

```bash
curl -u "bloknodes:bloknodes" -d '{"jsonrpc": "1.0", "id": "curl", "method": "getblockcount", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:19332/wallet/test-wallet | jq -r '.result'
1384738

curl -u "bloknodes:bloknodes" -d '{"jsonrpc": "1.0", "id": "curl", "method": "getblockhash", "params": [1384738]}' -H 'content-type: text/plain;' http://127.0.0.1:19332/wallet/test-wallet | jq -r '.result'
00000000000000485f3ab8524134f079b472456a182c22917647abcd04532893

curl -u "bloknodes:bloknodes" -d '{"jsonrpc": "1.0", "id": "curl", "method": "getblock", "params": ["00000000000000485f3ab8524134f079b472456a182c22917647abcd04532893"]}' -H 'content-type: text/plain;' http://127.0.0.1:19332/wallet/test-wallet | jq .

{
  "result": {
    "hash": "00000000000000485f3ab8524134f079b472456a182c22917647abcd04532893",
    "confirmations": 9299,
    "strippedsize": 998027,
    "size": 998606,
    "weight": 3992687,
    "height": 1384738,
    "version": 536870912,
    "versionHex": "20000000",
    "merkleroot": "2bd00b9b1ad746256414fcdb6ebeb4e872a2175cf2cda9986aeacef7e793cd8d",
    "tx": [
      "af319e276e33123f62980b43eb0265772384f433f49dcdbeeef8e6319c806a70",
      "68c26ce2ad7389a71a21d4d037436d73f9dce125488edf85451fda1100a9eb29",
...
```

To see how many blocks still have to sync:

```bash
headers=$(curl -s -u "bloknodes:bloknodes" -d '{"jsonrpc": "1.0", "id": "curl", "method": "getblockchaininfo", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:19332/ | jq -r '.result.headers')
blocks=$(curl -s -u "bloknodes:bloknodes" -d '{"jsonrpc": "1.0", "id": "curl", "method": "getblockchaininfo", "params": []}' -H 'content-type: text/plain;' http://127.0.0.1:19332/ | jq -r '.result.blocks')

echo "blocks=$blocks / headers=$headers"
echo "blocks to sync:"
echo "$headers - $blocks" | bc
```  

</details>
