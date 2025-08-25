defmodule Newsletter do
  def read_emails(path) do
    case File.read(path) do
      {:ok, text} ->
        text
        |> String.trim()
        |> String.split("\n")

      {:error, _} ->
        []
    end
  end

  def open_log(path) do
    File.open!(path, [:read, :write])
  end

  def log_sent_email(pid, email) do
    IO.write(pid, "#{email}\n")
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    emails = read_emails(emails_path)
    log = open_log(log_path)

    Enum.each(emails, fn email ->
      case send_fun.(email) do
        :ok -> log_sent_email(log, email)
        _ -> :noop
      end
    end)

    close_log(log)
    :ok
  end
end
