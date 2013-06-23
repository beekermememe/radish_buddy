class UserInfoViewController  < UIViewController

  def viewDidLoad
    super
    @user_getter = UserInfo.new($config[:uuid])
    @form = nil
    @user_getter.get do |user|
      update_user_details(user)
    end
  end

  def set_devices(user)
    font = UIFont.boldSystemFontOfSize(12)
    lbl = UILabel.alloc.initWithFrame([[0, 20], [320, 20]])
    lbl.text = "Devices(#{user['devices'].count})"
    lbl.font = font
    view << lbl
    dev_count = 1
    font = UIFont.systemFontOfSize(12)

    user['devices'].each do |dev|
      y_down = (40*dev_count)
      lbl = UILabel.alloc.initWithFrame([[0, y_down], [320, 20]])
      lbl.text = "  Device: \n#{dev["device_guid"]} - #{dev["player_type"]}"
      lbl.font = font
      view << lbl
      lbl = UILabel.alloc.initWithFrame([[0, y_down+20], [320, 20]])
      lbl.text = "       \n#{dev["device_machine_os"]} - #{dev["device_last_video_auth"]}"
      lbl.font = font
      view << lbl
      lbl.font = font
      view << lbl
      dev_count += 1
    end
    new_start_point = (40*dev_count)
    return new_start_point
  end

  def set_uuid(user)
    font = UIFont.systemFontOfSize(12)
    lbl = UILabel.alloc.initWithFrame([[0, 0], [320, 20]])
    lbl.text = "UUID\n#{user['uuid']}"
    lbl.font = font
    view << lbl
  end

  def set_parental_controls(user,start_point)
    font = UIFont.boldSystemFontOfSize(12)
    lbl = UILabel.alloc.initWithFrame([[0, start_point], [320, 20]])
    lbl.text = "Parental Controls"
    lbl.font = font
    view << lbl
    font = UIFont.systemFontOfSize(12)
    lbl = UILabel.alloc.initWithFrame([[0, start_point+20], [320, 20]])
    text = "  Block Unrated - "
    text += "Shows : #{user['parental_controls']['block_unrated_shows']} / "
    text += "Movies : #{user['parental_controls']['block_unrated_movies']} "
    lbl.text = text
    lbl.font = font
    view << lbl
    lbl = UILabel.alloc.initWithFrame([[0, start_point+40], [320, 20]])
    text = "  Movie Ratings to Block - "
    text += "#{user['parental_controls']['movie_ratings_to_block']}"
    lbl.text = text
    lbl.font = font
    view << lbl
    lbl = UILabel.alloc.initWithFrame([[0, start_point+60], [320, 20]])
    text = "  Show Ratings to Block - "
    text += "#{user['parental_controls']['show_ratings_to_block']}"
    lbl.text = text
    lbl.font = font
    view << lbl
  end

  def update_user_details(user)
    set_uuid(user)
    next_start_point = set_devices(user)
    set_parental_controls(user,next_start_point)
  end
end