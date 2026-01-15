# pickle.yazi

A [Yazi](https://yazi-rs.github.io/) plugin to preview Python pickle (`.pkl`, `.pickle`) files in the terminal.

## Features

- Pretty-printed preview of pickle file contents
- Shows data type information
- Scrollable preview for large data structures
- No external dependencies (uses Python's built-in modules)

## Requirements

- Python 3 (system Python works fine)

## Installation

### Using `ya pack`

```bash
ya pack -a dimi1357/pickle
```

### Manual Installation

1. Clone to your yazi plugins directory:

```bash
git clone https://github.com/dimi1357/pickle.yazi.git ~/.config/yazi/plugins/pickle.yazi
```

2. Add to your `~/.config/yazi/yazi.toml`:

```toml
[plugin]
prepend_previewers = [
    { url = "*.pkl", run = "pickle" },
    { url = "*.pickle", run = "pickle" },
]
```

## Example Output

```
Type: dict
────────────────────────────────────────
{ 'config': {'learning_rate': 0.001, 'epochs': 100},
  'data': [1, 2, 3, 4, 5],
  'model': 'neural_network'}
```

## License

MIT License - see [LICENSE](LICENSE) for details.
