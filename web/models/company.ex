defmodule Outcomes.Company do
  use Outcomes.Web, :model

  schema "companies" do
    field :name, :string

    timestamps()

    has_many :jobs, Outcomes.Job
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end

  def select_opts(companies) do
    Enum.flat_map companies, fn(company) -> company_tuple(company) end
  end

  def company_tuple(company) do
    %{"#{company.name}": company.id}
  end
end
