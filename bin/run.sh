#!/usr/bin/env bash

NETWORK=${NETWORK:-testnet}

function run_mainnet(){
  echo "[INFO] Running litecoin in MAINNET chain"
  /usr/bin/litecoind -conf=/etc/litecoin/mainnet.conf -daemon=0
}

function run_testnet(){
  echo "[INFO] Running litecoin in TESTNET chain"
  /usr/bin/litecoind -conf=/etc/litecoin/testnet.conf -daemon=0
}

if [ "${NETWORK}" == "mainnet" ]
then
  run_mainnet
else
  run_testnet
fi