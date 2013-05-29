class Shows

  def initialize(start_page = 1, items_per_page = 20, uuid = "B5BE587F67D656C5E0441CC1DE313A0C")
    @start_page = start_page
    @items_per_page = items_per_page
    @uuid = uuid
  end

  def get(&callback)
    itemstart = (@start_page*@items_per_page) + 1
    AFMotion::Client.shared.get("v20/dol/shows.json", { uuid: @uuid, itemStart: itemstart, totalItems:  @items_per_page, nkey: Time.now.to_i }) do |result|
      if result.success?
        puts "\n -- #{result.object["shows"].count}\n first = #{result.object["shows"].first}| \n last = #{result.object["shows"].last}|\n"
        shows = result.object["shows"]
        callback.call(shows)
      else
       #something went wrong
        puts "No shared client set or #{result.inspect} or #{result.error.localizedDescription}!"
        shows = []
      end
    end
  end



end