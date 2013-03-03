class Movies

  def initialize(config)

  end

  def self.get(&callback)
    AFMotion::Client.shared.get("/v20/dol/movies.json", { uuid: $config[:uuid], totalItems: 150, nkey: Time.now.to_i}) do |result|
      if result.success?
        puts "\n |--| #{result.object}"
        puts "\n -- #{result.object["movies"].count}\n first = #{result.object["movies"].first}| \n last = #{result.object["movies"].last}|\n"
        movies = result.object["movies"]
        callback.call(movies)
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