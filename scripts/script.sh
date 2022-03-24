#!/bin/bash

function clone_dap ()
{
  git clone https://github.com/Microsoft/vscode-chrome-debug
  cd ./vscode-chrome-debug
  npm install
  npm run build

  cd ../

  git clone https://github.com/microsoft/vscode-node-debug2.git
  cd vscode-node-debug2
  npm install
  npm run build
}

if [[ -d ./config-debug/ ]]; then
  cd /config-debug/

  if [[ ! -d ./config-debug/microsoft ]]; then
    mkdir ./microsoft/
    cd ./microsoft/
    clone_dap
  else
    cd ./microsoft/
    clone_dap
  fi

else  
  mkdir -p ./config-debug/microsoft/ && cd ./config-debug/microsoft/
  clone_dap

fi
