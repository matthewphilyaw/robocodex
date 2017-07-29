defmodule Robocodex do
  @url "http://localhost:4000/api/command"

  @bot_radius 20
  @heading_length 30
  @radar_arc 45
  @radar_radius 300
  @cannon_length 40

  def dtr(degrees) do
    degrees * (:math.pi / 180)
  end

  def send_init do
    init_cmd = %{
      "method" => "init",
      "height" => 700,
      "width" => 1200,
      "arenaColor" => "black",
      "arenaBorderColor" => "white"
    }

    send_req(init_cmd)
  end

  def create_robot(x, y, ba, ra, ca, bc, rc, cc) do
    %{
      "x" => x,
      "y" => y,
      "radius" => @bot_radius,
      "color" => bc,
      "heading" => %{
        "angle" => dtr(ba),
        "length" => @heading_length,
        "color" => bc
      },
      "radar" => %{
        "angle" => dtr(ra),
        "arcAngle" => dtr(@radar_arc),
        "radius" => @radar_radius,
        "color" => rc
      },
      "cannon" => %{
        "angle" => dtr(ca),
        "length" => @cannon_length,
        "color" => cc
      }
    }
  end

  def send_draw(bots) do
    draw_cmd = %{
      "method" => "draw",
      "bots" => bots
    }

    send_req(draw_cmd)
  end

  def send_req(data) do
    json = Poison.encode!(data)

    HTTPoison.post!(@url, json, [{"Content-Type", "application/json"}])
  end

  def run(repeat_ms, state) do
    {r1, r2} = state

    bot1 = create_robot 400, 400, 15, r1, 160, "white", "green", "red"
    bot2 = create_robot 800, 400, 45, r2, 190, "yellow", "green", "red"

    send_draw [bot1, bot2]

    :timer.sleep(repeat_ms)

    state = {r1 + 2, r2 + 12}
    run(repeat_ms, state)
  end
end
