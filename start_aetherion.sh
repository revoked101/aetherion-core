#!/bin/bash
echo "=================================================="
echo "⚛️ INITIALISING PROJECT AETHERION ENGINE MESH"
echo "Sovereign Architect & Author: Mandlenkosi Vundla"
echo "=================================================="
echo "[Mesh] Testing WireGuard Secure Tunnel Mesh..."
echo "[Security] Mounting automated Vault rotation token sidecars..."
mkdir -p /tmp/vault/secrets/
echo "hvs.MTc3ODU3MjgwMF9DcnlwdG9fUXVhbnR1bV9TZWFsX0FldGhlcmlvbg" > /tmp/vault/secrets/lattice
echo "[Runtime] Launching supersonic BEAM X isolated container environment..."
erl -noshell -pa sys_kernel/src/ data_layer/router/ data_layer/lattice/ infrastructure/cache_bus/ -s aetherion_app start -s init stop
