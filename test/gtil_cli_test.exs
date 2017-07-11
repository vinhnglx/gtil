defmodule GtilCliTest do
  use ExUnit.Case
  doctest Gtil

  import Gtil.Cli

  test "returns :help when passing -h or --help option" do
    assert run(["-h"]) == help_info()
    assert run(["--help"]) == help_info()
    assert run(["blabla"]) == help_info()
  end

  def help_info do
    "
      fetch <name> <repo> <count>       Display table of last _count_ issues from <repo>
    "
  end
end
