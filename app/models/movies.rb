class Movies

  def initialize(config)

  end

  def self.get(&callback)
    AFMotion::Client.shared.get("/v20/dol/movies.json", { uuid: $config[:uuid], totalItems: 30 }) do |result|
      if result.success?
        puts "\n -- #{result.object.count}\n first = #{result.object.first}| \n last = #{result.object.last}|\n"
        movies = result.object
        callback.call(movies)
      else
       #something went wrong
        puts "No shared client set or #{result.inspect} or #{result.error.localizedDescription}!"
        movies = []
        raise result.error.localizedDescription
      end
    end
  end



end