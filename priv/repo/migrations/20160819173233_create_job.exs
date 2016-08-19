defmodule Outcomes.Repo.Migrations.CreateJob do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :name, :string
      add :company_id, references(:companies, on_delete: :nothing)

      timestamps()
    end
    create index(:jobs, [:company_id])

  end
end
