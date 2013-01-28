class Movies

  def initialize(config)
    @baseurl = config["url"]
    @uuid = config["uuid"]
  end

  def get
    AFMotion::Client.shared.get("#{@baseurl}/v20/dol/movies.json", uuid: @uuid) do |result|
      if result.success?
        json = result.object
        return json
      else
       #something went wrong
        raise result.error.localizedDescription
      end
    end

  end



end