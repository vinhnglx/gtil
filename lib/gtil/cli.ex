defmodule Gtil.Cli do
  @moduledoc """
    This module parses command line options and dispatch to various functions that end up generating a tool to push
    a issue and display table of last _n_ issues in a GitHub TIL.
  """

  def run(args) do
    args
      |> parse_args
      |> process
  end

  @doc """
    `args` can be:

    -h, --help returns :help
    -
  """
  def parse_args(args) do
    parse = OptionParser.parse(args,
              switches: [
                help: :boolean,
                fetch: :boolean, name: :string, repo: :string, count: :integer, label: :string,
                push: :boolean, title: :string, body: :string, labels: :string
              ],
              aliases: [h: :help, f: :fetch, n: :name, r: :repo, c: :count, l: :label])

    case parse do
      {[help: true], _, _} -> :help
      {[fetch: true, name: name, repo: repo, count: count, label: label], _, _} -> {name, repo, count, label}
      _ -> :help
    end
  end

  @doc """
    Display helper information
  """
  def process(:help) do
    "
      --help, -h        List of available commands
      --fetch, -f       Fetch the issues
      --name, -n        GitHub username
      --repo, -r        Repository name
      --label, -l       Issue's label
      --count, -c       The number of issues want to be display. Default is 5
    "
  end

  @doc """
    Dispatch to Fetch function
  """
  def process({user, til_repo, count, label}) do
    {user, til_repo, count, label}
  end
end
