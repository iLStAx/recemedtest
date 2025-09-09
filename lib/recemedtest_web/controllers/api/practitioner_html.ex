defmodule RecemedtestWeb.Api.PractitionerHTML do
  use RecemedtestWeb, :html

  embed_templates "practitioner_html/*"

  @doc """
  Renders a practitioner form.

  The form is defined in the template at
  practitioner_html/practitioner_form.html.heex
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :return_to, :string, default: nil

  def practitioner_form(assigns)
end
