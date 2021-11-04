defmodule GenLocation.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      GenLocation.Repo,
      # Start the Telemetry supervisor
      GenLocationWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: GenLocation.PubSub},
      # Start the Endpoint (http/https)
      GenLocationWeb.Endpoint,
      # Start a worker by calling: GenLocation.Worker.start_link(arg)
      # {GenLocation.Worker, arg}

      {GenLocation.Producer, 0},
      {GenLocation.ProducerConsumer, []},
      %{
        id: 1,
        start: {GenLocation.Consumer, :start_link, [[]]}
      },
      %{
        id: 2,
        start: {GenLocation.Consumer, :start_link, [[]]}
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GenLocation.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    GenLocationWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
