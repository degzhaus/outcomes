defmodule Outcomes.Repo.Migrations.CreateApplication do
  use Ecto.Migration

  def change do
    create table(:applications) do
      add :name, :string
      add :job_id, references(:jobs, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:applications, [:job_id])
    create index(:applications, [:user_id])

  end
end
