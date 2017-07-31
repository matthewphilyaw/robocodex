defmodule Robocodex do
  alias Robocodex.Display
  alias Robocodex.Arena
  alias Robocodex.Bot

  require Logger

  def run(repeat_ms) do
    arena_conf = (Application.get_env :robocodex, :game).arena

    arena = Arena.create(arena_conf.width, arena_conf.height)

    Display.send_init(arena)

    bot1 = Bot.create({400, 400}, (:math.pi / 6), "white")
    bot2 = Bot.create({800, 400}, (:math.pi / 2), "red")

    r1 = dtr(15)
    r2 = dtr(30)

    bot1 = %{ bot1 | radar_arc_center: r1,
                     radar_arc: 0,
                     radar_angle: r1 }

    bot2 = %{ bot2 | radar_arc_center: r2,
                     radar_arc: 0,
                     radar_angle: r2 }

    run(arena, repeat_ms, {bot1, bot2})
  end

  def run(arena, repeat_ms, state) do
    {bot1, bot2} = state

    r1 = bot1.radar_angle + dtr(3)
    r2 = bot2.radar_angle + dtr(30)

    arc1 = (r1 - bot1.radar_angle)
    arc2 = (r2 - bot2.radar_angle)

    bot1 = %{ bot1 | radar_arc_center: r1 - (arc1 / 2),
                     radar_arc: arc1,
                     radar_angle: r1 }

    bot2 = %{ bot2 | radar_arc_center: r2 - (arc2 / 2),
                     radar_arc: arc2,
                     radar_angle: r2 }

    arena = %{ arena | bots: [bot1, bot2] }

    Display.send_draw(arena)

    :timer.sleep(repeat_ms)

    run(arena, repeat_ms, {bot1, bot2})
  end

  def dtr(degrees) do
    degrees * (:math.pi / 180)
  end

end
