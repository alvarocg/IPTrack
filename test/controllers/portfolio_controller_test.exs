defmodule Iptrack.PortfolioControllerTest do
  use Iptrack.ConnCase

  alias Iptrack.Portfolio
  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, portfolio_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing portfolios"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, portfolio_path(conn, :new)
    assert html_response(conn, 200) =~ "New portfolio"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, portfolio_path(conn, :create), portfolio: @valid_attrs
    assert redirected_to(conn) == portfolio_path(conn, :index)
    assert Repo.get_by(Portfolio, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, portfolio_path(conn, :create), portfolio: @invalid_attrs
    assert html_response(conn, 200) =~ "New portfolio"
  end

  test "shows chosen resource", %{conn: conn} do
    portfolio = Repo.insert! %Portfolio{}
    conn = get conn, portfolio_path(conn, :show, portfolio)
    assert html_response(conn, 200) =~ "Show portfolio"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, portfolio_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    portfolio = Repo.insert! %Portfolio{}
    conn = get conn, portfolio_path(conn, :edit, portfolio)
    assert html_response(conn, 200) =~ "Edit portfolio"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    portfolio = Repo.insert! %Portfolio{}
    conn = put conn, portfolio_path(conn, :update, portfolio), portfolio: @valid_attrs
    assert redirected_to(conn) == portfolio_path(conn, :show, portfolio)
    assert Repo.get_by(Portfolio, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    portfolio = Repo.insert! %Portfolio{}
    conn = put conn, portfolio_path(conn, :update, portfolio), portfolio: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit portfolio"
  end

  test "deletes chosen resource", %{conn: conn} do
    portfolio = Repo.insert! %Portfolio{}
    conn = delete conn, portfolio_path(conn, :delete, portfolio)
    assert redirected_to(conn) == portfolio_path(conn, :index)
    refute Repo.get(Portfolio, portfolio.id)
  end
end
