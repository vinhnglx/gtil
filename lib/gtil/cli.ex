defmodule Gtil.Cli do
  @moduledoc """
    This module parses command line options and dispatch to various functions that end up generating a tool to push
    a issue and display table of last _n_ issues in a GitHub TIL.
  """

  def run(args) do
    parse_args(args)
  end

  @doc """
    `args` can be:

    -h, --help returns :help
    user, til_repo, count returns {user, til_repo, count}
  """
  def parse_args(args) do
    parse = OptionParser.parse(args, switches: [help: :boolean], aliases: [h: :help])

    case parse do
      {[help: true], _, _} -> help_info()
      _ -> help_info()
    end
  end

  @doc """
    Display helper information
  """
  defp help_info do
    "
      fetch <name> <repo> <count>       Display table of last _count_ issues from <repo>
    "
  end
end