class SingleNetworkTableViewController < UITableViewController
  def viewDidLoad
    super
    # Uncomment the following line to preserve selection between presentations.

    # self.clearsSelectionOnViewWillAppear = false

    # Uncomment the following line to display an Edit button in the navigation
    # bar for this view controller.

    # self.navigationItem.rightBarButtonItem = self.editButtonItem
    @network_values_to_show = [
      "logo",
      "is_locked",
      "url",
      "has_stream",
      "banner",
      "slug"
    ]

    self.navigationItem.title = @network.nil? ? "" : @network["name"]
  end

  def viewDidUnload
    super

    # Release any retained subviews of the main view.
    # e.g. self.myOutlet = nil
  end


  def has_thumbnail(thumbnail)
    !thumbnail.nil? && (thumbnail.include?("jpg") || thumbnail.include?("png") || thumbnail.include?("gif"))
  end

  def is_locked(locked)
    (!locked.nil? && (locked == "true" || locked == "locked"))
  end

  def is_p_locked(locked)
    (!locked.nil? && (locked == "true" || locked == "locked"))
  end

  def set_network(network)
    @network = network
    view.reloadData
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end

## Table view data source

  def numberOfSectionsInTableView(tableView)
    # Return the number of sections.
    1
  end

  def tableView(tableView, numberOfRowsInSection:section)
    # Return the number of rows in the section.
    @network_values_to_show.nil? ? 0 : @network_values_to_show.count
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)


    cellIdentifier = self.class.name
    cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
    # Configure the cell...
    unless cell
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: cellIdentifier)
    end
    value = nil
    key =  @network_values_to_show[indexPath.row]
    if @network.nil?
      value = ""
    elsif key == "logo"
      ht = has_thumbnail(@network["logo"])
      value = "#{ht == true ? "#{@network['logo']}" : "NO LOGO"}"
    elsif key == "is_locked"
      lk = is_locked(@network[key])
      value = "#{lk == true ? "LOCKED" : "UNLOCKED"}"
    elsif @network[key].nil? || @network[key] == ""
      value = "#{key} is blank"
    else
      value = "#{key}: #{@network[key]}"
    end
    cell.textLabel.text = "#{value}"
    cell
  end

=begin
  # Override to support conditional editing of the table view.
  def tableView(tableView, canEditRowAtIndexPath:indexPath)
    # Return false if you do not want the specified item to be editable.
    true
  end
=end

=begin
  # Override to support editing the table view.
  def tableView(tableView, commitEditingStyle:editingStyle forRowAtIndexPath:indexPath)
    if editingStyle == UITableViewCellEditingStyleDelete
      # Delete the row from the data source
      tableView.deleteRowsAtIndexPaths(indexPath, withRowAnimation:UITableViewRowAnimationFade)
    elsif editingStyle == UITableViewCellEditingStyleInsert
      # Create a new instance of the appropriate class, insert it into the
      # array, and add a new row to the table view
    end
  end
=end

=begin
  # Override to support rearranging the table view.
  def tableView(tableView, moveRowAtIndexPath:fromIndexPath, toIndexPath:toIndexPath)
  end
=end

=begin
  # Override to support conditional rearranging of the table view.
  def tableView(tableView, canMoveRowAtIndexPath:indexPath)
    # Return false if you do not want the item to be re-orderable.
    true
  end
=end

## Table view delegate

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    # Navigation logic may go here. Create and push another view controller.
    # detailViewController = DetailViewController.alloc.initWithNibName("Nib name", bundle:nil)
    # Pass the selected object to the new view controller.
    # self.navigationController.pushViewController(detailViewController, animated:true)
  end
end