defmodule PhxInPlaceDemo.Repo do
  use Ecto.Repo, otp_app: :phx_in_place_demo

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end
end
