defmodule Robocodex.Arena do
  defstruct height: 0,
            width: 0,
            bots: []

  def create(width, height) do
    %Robocodex.Arena{
      height: height,
      width: width
    }
  end

end
