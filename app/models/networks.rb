class Networks

  def initialize(config)

  end

  def self.get(&callback)
    AFMotion::Client.shared.get("/v20/dol/networks.json", { uuid: $config[:uuid], totalItems: 150, nkey: Time.now.to_i }) do |result|
      if result.success?
        puts "\n -- #{result.object.count}\n first = #{result.object.first}| \n last = #{result.object.last}|\n"
        networks = result.object
        callback.call(networks)
      else
       #something went wrong
        puts "No shared client set or #{result.inspect} or #{result.error.localizedDescription}!"
        networks = []
        raise result.error.localizedDescription
      end
    end
  end



end