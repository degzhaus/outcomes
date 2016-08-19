defmodule Outcomes.Application do
  use Outcomes.Web, :model

  schema "applications" do
    field :name, :string
    field :placed_at, Ecto.DateTime

    belongs_to :job, Outcomes.Job
    belongs_to :user, Outcomes.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :job_id, :user_id], [:placed_at])
    |> validate_required([:name])
    |> validate_required([:job_id])
    |> validate_required([:user_id])
  end
end
