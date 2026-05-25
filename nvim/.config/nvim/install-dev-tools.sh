#!/usr/bin/env sh

set -eu

info() {
	printf '\033[1;34m==>\033[0m %s\n' "$*"
}

warn() {
	printf '\033[1;33mWARN:\033[0m %s\n' "$*" >&2
}

has() {
	command -v "$1" >/dev/null 2>&1
}

info "Installing Neovim formatter and Treesitter helper tools"

if has cargo; then
	info "Installing Rust/Cargo tools: stylua, tree-sitter-cli"
	cargo install stylua tree-sitter-cli
else
	warn "cargo not found; skipping stylua and tree-sitter-cli"
fi

if has rustup; then
	info "Installing rustfmt through rustup"
	rustup component add rustfmt
else
	warn "rustup not found; skipping rustfmt"
fi

if has go; then
	info "Installing Go tools: goimports"
	go install golang.org/x/tools/cmd/goimports@latest
	info "gofmt comes with Go; no separate install needed"
else
	warn "go not found; skipping goimports and gofmt"
fi

if has npm; then
	info "Installing Node tools: prettier"
	npm install -g prettier
else
	warn "npm not found; skipping prettier"
fi

if has python3; then
	if python3 -m pip --version >/dev/null 2>&1; then
		info "Installing Python tools: black"
		python3 -m pip install --user --upgrade black
	else
		warn "python3 is installed but pip is missing; skipping black"
	fi
else
	warn "python3 not found; skipping black"
fi

if has clang-format; then
	info "clang-format already exists: $(command -v clang-format)"
else
	warn "clang-format is not installed. Install it with your system package manager."
fi

if has zig; then
	info "zigfmt comes with Zig; no separate install needed"
else
	warn "zig not found; skipping zigfmt"
fi

info "Done"
