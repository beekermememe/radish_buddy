class MoviesTableViewController < UITableViewController
  def viewDidLoad
    super
    # Uncomment the following line to preserve selection between presentations.

    # self.clearsSelectionOnViewWillAppear = false

    # Uncomment the following line to display an Edit button in the navigation
    # bar for this view controller.
    @movies = []
    Dispatch::Queue.concurrent('mc-data').async {
      Movies.get do |mvs|
        updatemovies(mvs)
      end
    }
  end

  def viewDidUnload
    super

    # Release any retained subviews of the main view.
    # e.g. self.myOutlet = nil
  end

  def updatemovies(mvs)
    @movies = mvs
    view.reloadData
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end

## Table view data source

  def numberOfSectionsInTableView(tableView)
    # Return the number of sections.
    1 # @movies ? @movies.count : 0
  end

  def tableView(tableView, numberOfRowsInSection:section)
    # Return the number of rows in the section.
    @movies ? @movies.count : 0
    #(@movies && @movies.count > 0) ? @movies[0].count : 0
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cellIdentifier = self.class.name
    cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
    unless cell
        cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: cellIdentifier)
    end
    movie = @movies[indexPath.row]['movie']
    if movie['is_locked'] == true || movie['is_locked'] == "true"
      locked_view = "padlock-icon-hi".uiimage
    else
      locked_view = "unlocked".uiimage
    end
    networks = movie["networks"].map {|n| n["name"]}.join(",")
    cell.textLabel.text = "#{movie["name"]} (#{networks})"
    if movie['images']['poster_url'] == "http://img.dishonline.com"
      cell.textLabel.color = :red.uicolor
    else
      cell.textLabel.color = :green.uicolor
    end
    cell.accessoryView = UIImageView.alloc.initWithImage(locked_view)
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

    puts "selected movie -#{@movies[indexPath.row]['movie']['name']}"

    #controller = SingleMovieTableViewController.alloc.init
    #controller.set_movie(@movies[indexPath.row]['movie'])
      #controller.setconfig(self.configuration_data)
    #self.navigationController.pushViewController(controller, animated:true)

    controller = SingleMovieViewController.alloc.init
    controller.set_movie(@movies[indexPath.row]['movie'])
    self.navigationController.pushViewController(controller, animated:true)
    # Navigation logic may go here. Create and push another view controller.
    # detailViewController = DetailViewController.alloc.initWithNibName("Nib name", bundle:nil)
    # Pass the selected object to the new view controller.
    # self.navigationController.pushViewController(detailViewController, animated:true)
  end

  def resize_movie_image(image_path)


  end
end
