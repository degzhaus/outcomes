defmodule Outcomes.Job do
  use Outcomes.Web, :model

  schema "jobs" do
    field :name, :string

    timestamps()

    belongs_to :company, Outcomes.Company

    has_many :applications, Outcomes.Applications
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

  def select_opts(jobs) do
    Enum.flat_map jobs, fn(job) -> tuple(job) end
  end

  def tuple(job) do
    %{"#{job.name}": job.id}
  end
end
