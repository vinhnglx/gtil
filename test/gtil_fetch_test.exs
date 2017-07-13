defmodule GtilFetchTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  @github_url Application.get_env(:gtil, :github_url)

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes", "fixture/custom_cassettes")
    :ok
  end

  test "returns the response" do
    use_cassette "issue_response", custom: true do
      {:ok, response} = Gtil.Fetches.fetch("johndoe", "til")
      assert List.first(response)["id"] == 1
      assert List.first(response)["url"] == "#{@github_url}/repos/octocat/Hello-World/issues/1347"
    end
  end

  test "returns the error" do
    use_cassette "error_response", custom: true do
      {:error, error_response} = Gtil.Fetches.fetch("johndoe", "error")
      assert error_response["message"] == "Not Found"
    end
  end
end
