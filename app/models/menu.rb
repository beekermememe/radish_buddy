class Menu

  def self.items
    [
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
      },
      {
          name: "WhatsHot",
          tvc: "WhatsHotTableViewController"
      },
      {
          name: "UserInfo",
          tvc: "UserDetailsTableViewController"
      }
    ]
  end


end