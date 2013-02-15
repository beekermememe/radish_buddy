class Shows

  def initialize(config)

  end

  def self.get(&callback)
    AFMotion::Client.shared.get("/v20/dol/shows.json", { uuid: $config[:uuid], totalItems: 30, nkey: Time.now.to_i }) do |result|
      if result.success?
        puts "\n -- #{result.object.count}\n first = #{result.object.first}| \n last = #{result.object.last}|\n"
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