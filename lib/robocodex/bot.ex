defmodule Robocodex.Bot do
  defstruct position: {0, 0},
            heading: 0.0,
            radius: 0.0,
            color: "",
            radar_arc_center: 0.0,
            radar_arc: 0.0,
            radar_angle: 0.0,
            radar_radius: 0.0,
            radar_scan: [],
            cannon_angle: 0.0,
            velocity: 0

  def create(position, heading, color) do
    bot = Application.get_env(:robocodex, :game).bot
    %Robocodex.Bot{
      position: position,
      heading: heading,
      color: color,
      radius: bot.radius,
      radar_radius: bot.radar_radius
    }
  end

end
