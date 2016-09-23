defmodule Iptrack.PortfolioTest do
  use Iptrack.ModelCase

  alias Iptrack.Portfolio

  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Portfolio.changeset(%Portfolio{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Portfolio.changeset(%Portfolio{}, @invalid_attrs)
    refute changeset.valid?
  end
end
