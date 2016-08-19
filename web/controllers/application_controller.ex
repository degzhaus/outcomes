defmodule Outcomes.ApplicationController do
  use Outcomes.Web, :controller

  alias Outcomes.Application
  alias Outcomes.Job
  alias Outcomes.User

  def index(conn, _params) do
    applications = Repo.all(Application)
    render(conn, "index.html", applications: applications)
  end

  def new(conn, _params) do
    changeset = Application.changeset(%Application{})
    jobs = Job.select_opts(Repo.all(Job))
    students = student_select_opts()
    render(conn, "new.html", changeset: changeset, jobs: jobs, students: students)
  end

  def create(conn, %{"application" => application_params}) do
    changeset = Application.changeset(%Application{}, application_params)
    jobs = Job.select_opts(Repo.all(Job))
    students = student_select_opts()

    IO.inspect application_params

    case Repo.insert(changeset) do
      {:ok, _application} ->
        conn
        |> put_flash(:info, "Application created successfully.")
        |> redirect(to: application_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, jobs: jobs, students: students)
    end
  end

  def show(conn, %{"id" => id}) do
    application = Repo.get!(Application, id)
    render(conn, "show.html", application: application)
  end

  def edit(conn, %{"id" => id}) do
    application = Repo.get!(Application, id)
    changeset = Application.changeset(application)
    jobs = Job.select_opts(Repo.all(Job))
    students = student_select_opts()
    render(conn, "edit.html", application: application, changeset: changeset, jobs: jobs, students: students)
  end

  def update(conn, %{"id" => id, "application" => application_params}) do
    application = Repo.get!(Application, id)
    changeset = Application.changeset(application, application_params)
    jobs = Job.select_opts(Repo.all(Job))
    students = student_select_opts()

    case Repo.update(changeset) do
      {:ok, application} ->
        conn
        |> put_flash(:info, "Application updated successfully.")
        |> redirect(to: application_path(conn, :show, application))
      {:error, changeset} ->
        render(conn, "edit.html", application: application, changeset: changeset, jobs: jobs, students: students)
    end
  end

  def delete(conn, %{"id" => id}) do
    application = Repo.get!(Application, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(application)

    conn
    |> put_flash(:info, "Application deleted successfully.")
    |> redirect(to: application_path(conn, :index))
  end

  def student_select_opts do
    query = from User, where: [role: "student"]
    users = Repo.all(query)
    User.student_select_opts(users)
  end
end
