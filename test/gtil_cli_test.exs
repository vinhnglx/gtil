defmodule GtilCliTest do
  use ExUnit.Case
  doctest Gtil

  import Gtil.Cli#, only: [parse_args: 1]

  test "returns :help when passing -h or --help option" do
    assert run(["-h"]) == :help
    assert run(["--help"]) == :help
  end
end
