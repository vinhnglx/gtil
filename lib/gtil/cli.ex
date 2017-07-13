defmodule Gtil.Cli do
  @default_issue_count 5

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

    --help, -h
    --fetch, -f
    --name, -n
    --repo, -r
    --label, -l
    --count, -c
  """
  def parse_args(args) do
    parse = OptionParser.parse(args,
              switches: [
                help: :boolean,
                fetch: :boolean, name: :string, repo: :string, count: :integer, label: :string,
              ],
              aliases: [h: :help, f: :fetch, n: :name, r: :repo, c: :count, l: :label])

    case parse do
      {[help: true], _, _} -> :help
      {[fetch: true, name: name, repo: repo, count: count, label: label], _, _} -> {name, repo, count, label}
      {[fetch: true, name: name, repo: repo, label: label], _, _} -> {name, repo, @default_issue_count, label}
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
  def process({user, repo, _count, _label}) do
    Gtil.Fetches.fetch(user, repo)
  end
end
