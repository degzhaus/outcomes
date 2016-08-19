defmodule Outcomes.Job do
  use Outcomes.Web, :model

  schema "jobs" do
    field :name, :string

    timestamps()

    belongs_to :company, Outcomes.Company
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :company_id])
    |> validate_required([:name])
    |> validate_required([:company_id])
  end
end
