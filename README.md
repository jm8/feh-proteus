### to compile with simulator
```sh
nix build
```
### to run with simulator
```sh
nix run
```
### to build for physical device
```sh
nix build .#physical
```
then copy `result/.s19` to the sd card
(please note it's a hidden file lol)
### to get lsp (clangd)
```sh
nix develop -c sh -c 'printf -- "-xc++\n-I$simulatorsrc/Libraries" > compile_flags.txt'
```
lol