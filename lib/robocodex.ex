defmodule Robocodex do
  alias Robocodex.Display

  def run(repeat_ms, state) do
    {r1, r2} = state

    bot1 = Display.create_robot 400, 400, 15, r1, 160, "white", "green", "red"
    bot2 = Display.create_robot 800, 400, 45, r2, 190, "yellow", "green", "red"

    Display.send_draw [bot1, bot2]

    :timer.sleep(repeat_ms)

    state = {r1 + 2, r2 + 12}
    run(repeat_ms, state)
  end

end
