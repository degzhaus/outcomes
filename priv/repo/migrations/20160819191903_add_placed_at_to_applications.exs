defmodule Outcomes.Repo.Migrations.AddPlacedAtToApplications do
  use Ecto.Migration

  def change do
    alter table(:applications) do
      add :placed_at, :datetime
    end
  end
end
