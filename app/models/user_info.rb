class UserInfo

  def initialize(uuid = "B5BE587F67D656C5E0441CC1DE313A0C")
    @uuid = uuid
    @user = nil
  end

  def get(&callback)

    AFMotion::Client.shared.get("v20/dol/users/show.json", { uuid: @uuid}) do |result|
      if result.success?
        puts "\n |--| #{result.object}"
        @user = result.object
        callback.call(@user)
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