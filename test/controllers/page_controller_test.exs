defmodule Iptrack.PageControllerTest do
  use Iptrack.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to IPTrack"
  end
end
