## to compile with simulator
```sh
nix build
```
## to run
```sh
nix build
```
## to get lsp (clangd)
```sh
nix develop -c sh -c 'printf -- "-xc++\n-I$simulatorsrc/Libraries" > compile_flags.txt'
```
lol