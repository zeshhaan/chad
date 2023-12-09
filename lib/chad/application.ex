defmodule Chad.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ChadWeb.Telemetry,
      Chad.Repo,
      {DNSCluster, query: Application.get_env(:chad, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Chad.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Chad.Finch},
      # Start a worker by calling: Chad.Worker.start_link(arg)
      # {Chad.Worker, arg},
      # Start to serve requests, typically the last entry
      ChadWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Chad.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChadWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
