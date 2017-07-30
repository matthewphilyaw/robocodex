defmodule Robocodex.Display do

  def dtr(degrees) do
    degrees * (:math.pi / 180)
  end

  def send_init do
    arena = (Application.get_env :robocodex, :game).arena

    init_cmd = %{
      "method" => "init",
      "height" => arena.height,
      "width" => arena.width,
      "arenaColor" => arena.color,
      "arenaBorderColor" => arena.borderColor
    }

    send_req(init_cmd)
  end

  def create_robot(x, y, ba, ra, ca, bc, rc, cc) do
    bot = (Application.get_env :robocodex, :game).bot
    disp = Application.get_env :robocodex, :display

    %{
      "x" => x,
      "y" => y,
      "radius" => bot.radius,
      "color" => bc,
      "heading" => %{
        "angle" => dtr(ba),
        "length" => disp.heading_length,
        "color" => bc
      },
      "radar" => %{
        "angle" => dtr(ra),
        "arcAngle" => dtr(disp.radar_arc),
        "radius" => bot.radar_radius,
        "color" => rc
      },
      "cannon" => %{
        "angle" => dtr(ca),
        "length" => disp.cannon_length,
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
    disp = Application.get_env :robocodex, :display
    json = Poison.encode!(data)

    HTTPoison.post!(disp.url, json, [{"Content-Type", "application/json"}])
  end

end
