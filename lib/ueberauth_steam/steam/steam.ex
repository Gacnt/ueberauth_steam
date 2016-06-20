defmodule Ueberauth.Strategy.Steam.OpenID do
  
  @moduledoc """
  Steam OpenID

  Add `api_key` to your configuration

  config :ueberauth, Ueberauth.Strategy.Steam.OpenID, 
    api_key: System.get_env("STEAM_API_KEY")
  """

  use OAuth2.Strategy

  @defaults [
    strategy: __MODULE__,
    site: "https://steamcommunity.com/openid/login",
    callback: "/auth/steam/return",
    origin: "/"
  ]

  @doc """
  Construct a client for requests to Steam.

  This will be setup automatically for you in `Ueberauth.Strategy.Steam`.
  These options are only useful for usage outside the normal callback phase of 
  Ueberauth.
  """

  def client(opts \\ []) do
    config = Application.get_env(:ueberauth, Ueberauth.Strategy.Steam.OpenID)

    opts = 
      @defaults
      |> Keyword.merge(config)
      |> Keyword.merge(opts)

    OAuth2.Client.new(opts)
  end

  @doc """
  Provides the authorize url for the request phase of Ueberauth.
  No need to call this usually.
  """
  def authorize_url!(params \\ [], opts \\ []) do
    opts
    |> client
    |> OAuth2.Client.authorize_url!(params)
  end

  def get_token!(params \\ [], opts \\ []) do
    opts
    |> client
    |> OAuth2.Client.get_token!(params)
  end

  # Strategy Callbacks
  
  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end
end
