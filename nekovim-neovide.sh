#!/usr/bin/env bash

# Set all directory paths to match your existing setup
export NEKOVIM_CONFIG_DIR="${NEKOVIM_CONFIG_DIR:-"$HOME/.config/nekovim"}"
export NEKOVIM_DATA_DIR="${NEKOVIM_DATA_DIR:-"$HOME/.local/share/nekovim"}"
export NEKOVIM_CACHE_DIR="${NEKOVIM_CACHE_DIR:-"$HOME/.cache/nekovim"}"

# Launch neovide with the correct data directory
exec neovide -- \
  --cmd "let &runtimepath = '$NEKOVIM_CONFIG_DIR,' . &runtimepath" \
  --cmd "let &packpath = &runtimepath" \
  -u "$NEKOVIM_CONFIG_DIR/init.lua" \
  --cmd "lua vim.fn.stdpath = function(what) if what == 'data' then return '$NEKOVIM_DATA_DIR' else return vim.call('stdpath', what) end end" \
  "$@"
