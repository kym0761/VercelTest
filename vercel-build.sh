#!/usr/bin/env bash
set -euo pipefail

echo "Installing .NET SDK..."
curl -sSL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh
bash /tmp/dotnet-install.sh --channel 10.0 --install-dir "$HOME/.dotnet"
export PATH="$HOME/.dotnet:$PATH"
export DOTNET_NOLOGO=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1

echo ".NET SDK version:"
dotnet --version

echo "Publishing Blazor WebAssembly app..."
dotnet publish -c Release -o publish
