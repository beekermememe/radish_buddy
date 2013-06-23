class WhatsHot
  def initialize(start_page = 1, items_per_page = 20, uuid = "B5BE587F67D656C5E0441CC1DE313A0C")
    @start_page = start_page
    @items_per_page = items_per_page
    @uuid = uuid
  end
  def get(&callback)
    itemstart = (@start_page*@items_per_page) + 1

    AFMotion::Client.shared.get("v20/dol/whats_hot/index.json", { uuid: @uuid, itemStart: itemstart, totalItems: @items_per_page, nkey: Time.now.to_i }) do |result|
      if result.success?
        puts "\n |--| #{result.object}"
        puts "\n -- #{result.object.count}\n first = #{result.object.first}| \n last = #{result.object.last}|\n"
        whot = result.object
        callback.call(whot)
      else
        #something went wrong
        puts "\n |--| #{result.object}"
        puts "No shared client set or \n#{result.inspect}\n or #{result.error.localizedDescription}!"
        movies = []
        raise result.error.localizedDescription
      end
    end
  end
end