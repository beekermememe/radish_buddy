class Whatshot

  def initialize(config)

  end

  def self.get(&callback)
    AFMotion::Client.shared.get("/v20/dol/whats_hot/index.json", { uuid: $config[:uuid], totalItems: 30, genre: 'shows', region: "national" }) do |result|
      if result.success?
        puts "\n -- #{result.object.count}\n first = #{result.object.first}| \n last = #{result.object.last}|\n"
        whatshot = result.object
        callback.call(whatshot)
      else
       #something went wrong
        puts "No shared client set or #{result.inspect} or #{result.error.localizedDescription}!"
        movies = []
        raise result.error.localizedDescription
      end
    end
  end



end