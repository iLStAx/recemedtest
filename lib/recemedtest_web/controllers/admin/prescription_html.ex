defmodule RecemedtestWeb.Admin.PrescriptionHTML do
  use RecemedtestWeb, :html

  embed_templates "prescription_html/*"

  @doc """
  Renders a prescription form.

  The form is defined in the template at
  prescription_html/prescription_form.html.heex
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :return_to, :string, default: nil

  def prescription_form(assigns)
end
