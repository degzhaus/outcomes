defmodule Outcomes.User do
  use Outcomes.Web, :model

  schema "users" do
    field :name, :string
    field :password, :string
    field :role, :string

    timestamps()

    has_many :applications, Outcomes.Application
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :password, :role])
    |> validate_required([:name, :password, :role])
  end

  def student_select_opts(students) do
    Enum.flat_map students, fn(student) -> tuple(student) end
  end

  def tuple(student) do
    %{"#{student.name}": student.id}
  end
end
