defmodule Iptrack.PortfolioController do
  use Iptrack.Web, :controller

  alias Iptrack.Portfolio

  plug :scrub_params, "portfolio" when action in [:create, :update]

  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
          [conn, conn.params, conn.assigns.current_user])
  end

  def index(conn, _params, user) do
    portfolios = Repo.all(user_portfolios(user))
    render(conn, "index.html", portfolios: portfolios)
  end

  def new(conn, _params, user) do
    changeset = 
      user
      |> build_assoc(:portfolios)
      |> Portfolio.changeset()
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"portfolio" => portfolio_params}, user) do
    changeset =
      user
      |> build_assoc(:portfolios)
      |> Portfolio.changeset(portfolio_params)

    case Repo.insert(changeset) do
      {:ok, _portfolio} ->
        conn
        |> put_flash(:info, "Portfolio created successfully.")
        |> redirect(to: portfolio_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, user) do
    portfolio = Repo.get!(user_portfolios(user), id)
    render(conn, "show.html", portfolio: portfolio)
  end

  def edit(conn, %{"id" => id}, user) do
    portfolio = Repo.get!(user_portfolios(user), id)
    changeset = Portfolio.changeset(portfolio)
    render(conn, "edit.html", portfolio: portfolio, changeset: changeset)
  end

  def update(conn, %{"id" => id, "portfolio" => portfolio_params}, user) do
    portfolio = Repo.get!(user_portfolios(user), id)
    changeset = Portfolio.changeset(portfolio, portfolio_params)

    case Repo.update(changeset) do
      {:ok, portfolio} ->
        conn
        |> put_flash(:info, "Portfolio updated successfully.")
        |> redirect(to: portfolio_path(conn, :show, portfolio))
      {:error, changeset} ->
        render(conn, "edit.html", portfolio: portfolio, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    portfolio = Repo.get!(user_portfolios(user), id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(portfolio)

    conn
    |> put_flash(:info, "Portfolio deleted successfully.")
    |> redirect(to: portfolio_path(conn, :index))
  end

  defp user_portfolios(user) do
    assoc(user, :portfolios)
  end

end
