class Menu

  def self.items
    [
      {
        name: "Configure System",
        tvc: "ConfigurationTableViewController"
      },
      {
        name: "Movies",
        tvc: "MoviesTableViewController"
      },
      {
        name: "Shows",
        tvc: "ShowsTableViewController"
      },
      {
        name: "Networks",
        tvc: "NetworksTableViewController"
      }

    ]
  end


end