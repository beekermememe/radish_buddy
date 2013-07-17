class UserInfoViewController  < UITableViewController

  def viewDidLoad
    super
    @user_data = {}
    @user_getter = UserInfo.new($config[:uuid])
    @form = nil
    @user_getter.get do |user|
      update_user_table_details(user)
    end
  end

  def viewDidUnload
    super
  end

  def update_user_table_details(user)
    @user_data = user
    view.reloadData
  end

  def numberOfSectionsInTableView(tableView)
    # Return the number of sections.
    1
  end

  def tableView(tableView, numberOfRowsInSection:section)
    # Return the number of rows in the section.
    @user_data.count > 0 ? @user_data.count : 0
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cellIdentifier = self.class.name
    cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
    unless cell
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: cellIdentifier)
    end
    data_name =  @user_data[indexPath.row.to_i].nil?  ? '' : determine_cell_type(@user_data[indexPath.row.to_i].flatten[0],@user_data[indexPath.row.to_i])
    cell.textLabel.text = data_name
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
    cell
  end

  def determine_cell_type(data_name,data_hash)
    if data_name == 'uuid'
      "Summary Data "
    elsif data_name == 'devices'
      "Devices (#{data_hash[data_name].count})"
    elsif data_name == 'parental_controls'
      "Parental Control Settings"
    else
      data_name.upcase
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
    view.reloadData
  end

## Table view delegate
  def sub_view_controllers
    [
        UserParentalControlsViewController,
        SummaryDataViewController,
        DevicesDataViewController
    ]
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    newViewController = sub_view_controllers[indexPath.row.to_i].alloc.init
    newViewController.update_data(@user_data)
    # Navigation logic may go here. Create and push another view controller.
    # detailViewController = DetailViewController.alloc.initWithNibName("Nib name", bundle:nil)
    # Pass the selected object to the new view controller.
    self.navigationController.pushViewController(newViewController, animated:true)
  end
end