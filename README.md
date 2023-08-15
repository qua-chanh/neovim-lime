# NeoVim Lime

A hardcore NeoVim configuration.

## Treesitter

### Build parsers

```
npm install
tree-sitter generate
gcc -o parser.so -shared src/parser.c src/scanner.c -Os -I./src
```