# ExRsyncUsage

See test

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `ex_rsync_usage` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ex_rsync_usage, "~> 0.1.0"}]
    end
    ```

  2. Ensure `ex_rsync_usage` is started before your application:

    ```elixir
    def application do
      [applications: [:ex_rsync_usage]]
    end
    ```
## Usage

Generate a signature file.
```elixir
:rsync.sig("./test/data/sample1.png", "./test/data/sample1.sig")
```

Use the signature file to generate a delta.
```elixir
:rsync.delta("./test/data/sample1.sig", "./test/data/sample2.png", "./test/data/sample2.delta")
```

Use the delta to patch the original file to make a file equavelent to the file from which the patch was created.
```elixir
:rsync.patch("./test/data/sample1.png", "./test/data/sample2.delta", "./test/data/sample1_patched.png")
```

Ensure the original is equal to the new file
```elixir
File.read!("./test/data/sample2.png") == File.read!("./test/data/sample1_patched.png")
```
