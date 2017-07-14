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

  test "transform the response" do
    response = transform_response({:ok, '[{"id": 1, "url": "https://api.github.com/repos/johndoe/til/issues/1"}]'})
    assert List.first(response)["id"] == 1
    assert List.first(response)["url"] == "https://api.github.com/repos/johndoe/til/issues/1"
  end

  test "sort the response" do
    result = sort(fake_list([403,1010,10]))
    assert result |> Enum.map(fn(x)-> x["created_at"] end) == [10, 403, 1010]
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

  def fake_list(values) do
    for value <- values do
      %{"created_at" => value, "other_date" => "xxx"}
    end
  end
end
