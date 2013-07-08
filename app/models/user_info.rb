class UserInfo

  def initialize(uuid = "B5BE587F67D656C5E0441CC1DE313A0C")
    @uuid = uuid
    @user = nil
  end

  def get(&callback)

    AFMotion::Client.shared.get("v20/dol/users/show.json", { uuid: @uuid}) do |result|
      if result.success?
        puts "\nresult |--| #{result.object}"
        summary_data = []
        parental_controls_data = {}
        devices_data = {}
        @user = []

        result.object.each do |k,v|
          if k == 'devices'
            devices_data = v
          elsif k == 'parental_controls'
            parental_controls_data = v
          else
            summary_data.push({k => v})
          end
        end
        @user.push({'parental_controls_data' => parental_controls_data})
        @user.push({'summary_data' => summary_data})
        @user.push({'devices_data' => devices_data})
        puts "\n@user |--| #{@user.inspect}"
        callback.call(@user)
      else
        #something went wrong
        puts "\n |--| #{result.object}"
        puts "No shared client set or \n#{result.inspect}\n or #{result.error.localizedDescription}!"
        @user = []
        raise result.error.localizedDescription
      end
    end
  end

end