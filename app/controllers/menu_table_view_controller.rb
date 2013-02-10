class MenuTableViewController < UITableViewController
  attr_accessor :configuration_data, :afc_client_set
  def viewDidLoad
    super
    # Uncomment the following line to preserve selection between presentations.

    # self.clearsSelectionOnViewWillAppear = false

    # Uncomment the following line to display an Edit button in the navigation
    # bar for this view controller.

    # self.navigationItem.rightBarButtonItem = self.editButtonItem

  end

  def viewDidUnload
    super

    # Release any retained subviews of the main view.
    # e.g. self.myOutlet = nil
  end


  def set_configuration_data(data)
    $config = data
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
    Menu.items.count
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cellIdentifier = self.class.name
    cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
    unless cell
        cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: cellIdentifier)
    end
    cell.textLabel.text = Menu.items[indexPath.row][:name]
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
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
  def alert_no_config
    @alert_box = UIAlertView.alloc.initWithTitle("Warning",
        message:"You need to select a configuration",
        delegate: nil,
        cancelButtonTitle: "ok",
        otherButtonTitles:nil)

    # Show it to the user
    @alert_box.show
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    if $config[:username].nil? || $config[:username] == "" || $config[:server_url].nil? || $config[:server_url] == ""
      @afc_client = false
      #nil the client for AFNetworking
    else
      puts "\nusing -- #{$config[:server_url]} as base url"
      @afc_client = true
      AFMotion::Client.build_shared($config[:server_url]) do
        header "Accept", "application/json"
        operation :json
      end
    end

    if Menu.items[indexPath.row][:tvc] == "ConfigurationTableViewController"
      controller = Formotion::FormableController.alloc.initWithModel(Sysconfig.new("","",self))
      self.navigationController.pushViewController(controller, animated:true)
    elsif @afc_client == false
      alert_no_config
    elsif Menu.items[indexPath.row][:tvc] == "MoviesTableViewController"
      controller = MoviesTableViewController.alloc.init
      #controller.setconfig(self.configuration_data)
      self.navigationController.pushViewController(controller, animated:true)
    elsif Menu.items[indexPath.row][:tvc] == "ShowsTableViewController"
      controller = ShowsTableViewController.alloc.init
      #controller.setconfig(self.configuration_data)
      self.navigationController.pushViewController(controller, animated:true)
    else
      puts "\nWarning UNHANDLED-- #{self.configuration_data.inspect}"
    end
    # Navigation logic may go here. Create and push another view controller.
    # detailViewController = DetailViewController.alloc.initWithNibName("Nib name", bundle:nil)
    # Pass the selected object to the new view controller.
    # self.navigationController.pushViewController(detailViewController, animated:true)
  end
end
