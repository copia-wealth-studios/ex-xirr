# ExXirr

A library to calculate xirr using the [Newton Raphson method](https://en.wikipedia.org/wiki/Newton%27s_method).

## Usage

    iex> d = [{1985, 1, 1}, {1990, 1, 1}, {1995, 1, 1}]
    iex> v = [1000, -600, -200]
    iex> ExXirr.xirr(d,v)
    {:ok, -0.034592}


## Installation

The package can be installed as:

  1. Add ex_xirr to your list of dependencies in `mix.exs`:

      ```ex
      def deps do
        [
          {:ex_xirr, "~> 1.0.0", github: "copia-wealth-studios/ex-xirr"},
        ]
      end
      ```

  2. Ensure ex_xirr is started before your application:

      ```ex
      def application do
        [
          extra_applications: [:logger, :ex_xirr]
        ]
      end
      ```
## Test

- Run the test suite using the following
    ```
    MIX_ENV=test mix test
    ```

## Benchmarks

- We use benchee for the benchmark tests. Run it using the following
    ```
    mix run test/xirr_comparison_bench.exs
    ```

## Credits

This is a fork of [scripbox/ex-xirr](https://github.com/scripbox/ex-xirr).

This application is built on the fantastic [finance-elixir](https://github.com/tubedude/finance-elixir) package. Many thanks to [tubedude](https://github.com/tubedude) for his work.
