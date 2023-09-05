#!/bin/bash

dotnet pack
if dotnet tool list -g|grep proj99-azdev-tool; then
    dotnet tool uninstall --global proj99-azdev-tool
fi
dotnet tool install --global --add-source ./nupkg proj99-azdev-tool
