defmodule GtilFetchTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Gtil

  @github_url Application.get_env(:gtil, :github_url)

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes", "fixture/custom_cassettes")
    :ok
  end

  test "returns the response" do
    use_cassette "issue_response", custom: true do
      {:ok, response} = Gtil.Fetches.fetch("johndoe", "til")
      assert response =~ "#{@github_url}/repos/johndoe/til/issues/1"
    end
  end

  test "returns the error" do
    use_cassette "error_response", custom: true do
      {:error, error_response} = Gtil.Fetches.fetch("johndoe", "error")
      assert error_response =~ "Not Found"
    end
  end
end
