defmodule Gtil.Fetches do
  @moduledoc """
    Fetch a list of issues from command line options.
  """

  def fetch(user, repo) do
    HTTPoison.get!("https://api.github.com/repos/#{user}/#{repo}/issues")
    |> handle_response
  end

  def handle_response(%{body: body, status_code: 200}) do
    {:ok, Poison.Parser.parse!(body) }
  end

  def handle_response(%{body: body, status_code: _}) do
    {:error, Poison.Parser.parse!(body)}
  end
end
