use Mix.Config

config :robocodex,
  game: %{
    bot: %{
      radius: 20,
      radar_radius: 300,
    },
    arena: %{
      height: 700,
      width: 1200,
      color: "black",
      borderColor: "white"
    }
  },
  display: %{
    url: "http://localhost:4000/api/command",
    heading_length: 30,
    cannon_length: 40,
    radar_arc: 45
  }
