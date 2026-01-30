#!/usr/bin/env bash
set -euo pipefail

newman run postman/collection.json \
  -e postman/env.example.json \
  --reporters cli
