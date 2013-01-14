class Sysconfig
  include Formotion::Formable
  attr_accessor :username, :user_uuid, :user_slingid, :server

  form_property :username, :picker, items: ["Lab_Full_Qa", "Lab_Medium_Qa", "Lab_Low_Qa", "Hunter"]
  form_property :server, :picker, items:     [
      "http://www.dishanywhere.com/radish/",
      "http://radish.dishanywhere.com/",
      "http://staging.dishanywhere.com/radish/",
      "http://staging-radish01.dishonline.com/",
      "http://int.dishanywhere.com/radish/",
      "http://int-radish01.dishonline.com/",
      "http://qa.dishanywhere.com/radish/",
      "http://qa-radish01.dishonline.com/"
    ]

    form_title "Select User and Radish Server"

  def initialize(username,server,source)
    @root_config_holder = source
    @username = username
    @user_uuid = nil
    @user_slingid = nil
    self.set_user(username)
    @server = server
    self
  end

  def on_submit
    puts "set sysconfig"
    @root_config_holder.configuration_data = config
  end

  def config
    {
      username: self.username,
      sling_id: self.user_slingid,
      uuid: self.uuid,
      server: self.server
    }
  end

  def set_user(username)
    userinfo = nil
    user_list.each do |userdata|
      if userdata[:username] == username
        userinfo = userdata
        break
      end
    end
    unless userinfo.nil?
      self.username = username
      self.user_uuid = userinfo[:uuid]
      self.user_slingid = userinfo[:slingid]
    end
    self

  end

  def user_list
    [
      {
        username: "Lab_Full_Qa",
        sling_id: "",
        uuid: ""
      },
      {
        username: "Lab_Medium_Qa",
        sling_id: "",
        uuid: ""
      },
      {
        username: "Lab_Low_Qa",
        sling_id: "",
        uuid: ""
      },
      {
        username: "Hunter",
        sling_id: "",
        uuid: ""
      }
    ]
  end

  def server_list
    [
      "http://www.dishanywhere.com/radish/",
      "http://radish.dishanywhere.com/",
      "http://staging.dishanywhere.com/radish/",
      "http://staging-radish01.dishonline.com/",
      "http://int.dishanywhere.com/radish/",
      "http://int-radish01.dishonline.com/",
      "http://qa.dishanywhere.com/radish/",
      "http://qa-radish01.dishonline.com/"
    ]
  end
private






end