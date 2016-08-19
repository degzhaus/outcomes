defmodule Outcomes.User do
  use Outcomes.Web, :model

  schema "users" do
    field :name, :string
    field :password, :string
    field :role, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :password, :role])
    |> validate_required([:name, :password, :role])
  end
end
