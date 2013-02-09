class Movies

  def initialize(config)

  end

  def get
    AFMotion::Client.shared.get("/v20/dol/movies.json", uuid: $config[:uuid]) do |result|
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