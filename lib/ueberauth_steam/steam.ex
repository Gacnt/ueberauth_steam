defmodule Ueberauth.Strategy.Steam do
  @moduledoc """
  Steam Strategy for Ueberauth.
  """
  
  use Ueberauth.Strategy

  @doc """
  Handles initial request for Steam authentication
  """

  def handle_request!(conn) do
    allowed_params = conn
    |> option(:allowed_request_params)
    |> Enum.map(&to_string/1)
  end

end
