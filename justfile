alias c := clean
alias n := nightly
alias r := repl
alias s := stable

# List all available recipes.
default:
    @just --list

# Clean up build artifacts and temporary files.
[group("Maintenance")]
clean:
    rm -f result*

# Run the nightly helix configuration.
[group("Run")]
nightly *args:
    nix run .#nightly -- {{ args }}

# Enter the nix repl in debug mode.
[group("Develop")]
repl:
    NIX_DEBUG_REPL=1 nix repl --expr "builtins.getFlake \"$PWD\""

# Run the stable helix configuration.
[group("Run")]
stable *args:
    nix run .#stable -- {{ args }}
