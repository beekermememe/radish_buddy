class UserDevicesViewController < UITableViewController
  # To change this template use File | Settings | File Templates.
  def viewDidLoad
    view.backgroundColor = :gray.uicolor
    super
    # Do any additional setup after loading the view.
    @devices ||= []
    count = 0
    @devices.each do |device|
      create_device(device,count)
      count += 1
    end
    view
  end

  def viewDidUnload
    super
  end

  def set_devices(devices)
    @devices = []
    devices.each do |device,index|
      @devices.push(device_data(device,index))
    end
    view.reloadData
  end

  def numberOfSectionsInTableView(tableView)
    # Return the number of sections.
    @devices.count
  end

  def tableView(tableView, numberOfRowsInSection:section)
    # Return the number of rows in the section.
    @devices.count > 0 ? @devices[0].count : 0
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cellIdentifier = self.class.name
    cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
    unless cell
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: cellIdentifier)
    end

    cell.textLabel.text = determine_cell_type(@devices[indexPath.row].key,@devices[indexPath.row][:key].value)
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
    cell
  end

  def determine_cell_type(data_name,data_value)
    if data_type == 'uuid'
      "UUID"
    elsif data_type == 'devices'
      "DEVICES (#{data_value.count})"
    elsif data_type == 'unlocked_network_ids'
      "IDS OF UNLOCKED NETWORKS"
    else
      nil
    end
  end

  def device_data(device,number)
    [
      "Device Number : (#{number+1})" ,
      "GUID: #{device[:device_guid]}",
      "OS: #{device[:device_machine_os]}",
      "Last Video Watched : (#{device[:device_last_video_auth]})",
      "Player Type : (#{device[:player_type]})"
    ]
  end

end