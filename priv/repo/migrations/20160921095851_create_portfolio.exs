defmodule Iptrack.Repo.Migrations.CreatePortfolio do
  use Ecto.Migration

  def change do
    create table(:portfolios) do
      add :name, :string
      add :description, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:portfolios, [:user_id])

  end
end
