defmodule NameBadge do
  @spec print(integer() | nil, String.t(), String.t()) :: String.t()
  def print(id, name, department) do
    m_id = if id, do: "[#{id}] - ", else: ""
    m_dep = if department, do: String.upcase(department), else: "OWNER"
    "#{m_id}#{name} - #{m_dep}"
  end
end
