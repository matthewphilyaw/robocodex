defmodule Robocodex.Display do

  def dtr(degrees) do
    degrees * (:math.pi / 180)
  end

  def send_init(arena) do
    arena_conf = (Application.get_env :robocodex, :game).arena

    init_cmd = %{
      "method" => "init",
      "height" => arena.height,
      "width" => arena.width,
      "arenaColor" => arena_conf.color,
      "arenaBorderColor" => arena_conf.borderColor
    }

    send_req(init_cmd)
  end

  def create_robot(bot) do
    disp = Application.get_env :robocodex, :display

    {x, y} = bot.position
    %{
      "x" => x,
      "y" => y,
      "radius" => bot.radius,
      "color" => bot.color,
      "heading" => %{
        "angle" => bot.heading,
        "length" => disp.heading_length,
        "color" => bot.color
      },
      "radar" => %{
        "angle" => bot.radar_arc_center,
        "arcAngle" => bot.radar_arc,
        "radius" => bot.radar_radius,
        "color" => bot.color
      },
      "cannon" => %{
        "angle" => bot.cannon_angle,
        "length" => disp.cannon_length,
        "color" => bot.color
      }
    }
  end

  def send_draw(arena) do
    bots = Enum.map(arena.bots, &create_robot/1)

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
