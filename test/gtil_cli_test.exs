defmodule GtilCliTest do
  use ExUnit.Case
  doctest Gtil

  import Gtil.Cli

  test "returns :help when passing -h or --help option" do
    assert run(["-h"]) == help_info()
    assert run(["--help"]) == help_info()
    assert run(["blabla"]) == help_info()
  end

  test "fetch the issues with options name, repo, count and label" do
    assert parse_args(["--fetch", "--name", "vincent", "--repo", "test", "--count", "4", "--label", "elixir"]) == {"vincent", "test", 4, "elixir"}
    assert parse_args(["--fetch", "--name", "vincent", "--repo", "test", "--label", "elixir"]) == {"vincent", "test", 5, "elixir"}
  end

  def help_info do
    "
      --help, -h        List of available commands
      --fetch, -f       Fetch the issues
      --name, -n        GitHub username
      --repo, -r        Repository name
      --label, -l       Issue's label
      --count, -c       The number of issues want to be display. Default is 5
    "
  end
end
