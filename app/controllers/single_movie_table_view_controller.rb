class SingleMovieTableViewController < UITableViewController
  def viewDidLoad
    super
    # Uncomment the following line to preserve selection between presentations.

    # self.clearsSelectionOnViewWillAppear = false

    # Uncomment the following line to display an Edit button in the navigation
    # bar for this view controller.

    # self.navigationItem.rightBarButtonItem = self.editButtonItem
    @movie_values_to_show = [
      "is_locked",
      "description",
      "is_parental_locked",
      "rating",
      "poster_url",
      "slug"
    ]

    self.navigationItem.title = @movie.nil? ? "" : @movie["name"]
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
    (!locked.nil? && (locked == "true" || locked == true))
  end

  def is_p_locked(locked)
    (!locked.nil? && (locked == "true" || locked == true))
  end

  def set_movie(movie)
    @movie = movie
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
    @movie_values_to_show.nil? ? 0 : @movie_values_to_show.count
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)


    cellIdentifier = self.class.name
    cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
    # Configure the cell...
    unless cell
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: cellIdentifier)
    end
    value = nil
    key =  @movie_values_to_show[indexPath.row]
    if @movie.nil?
      cell.textLabel.text = ""
    elsif key == "poster_url"
      ht = has_thumbnail(@movie["images"]["poster_url"])
      if ht
        img = "#{@movie["images"]["poster_url"]}".uiimage
        img_v = UIImageView.alloc.initWithImage(img)
        cell.imageView.image = img
      else
        cell.textLabel.text = "No Poster Image Boooo"
      end
    elsif key == "is_locked"
      lk = is_locked(@movie[key])
      txt = "#{lk == true ? "LOCKED" : "UNLOCKED"}"
      lk = is_p_locked(@movie[key])
      ptx = "#{lk == true ? "PARENTAL LOCKED" : "PARENTAL UNLOCKED"}"
      cell.textLabel.text = "#{txt}/#{ptx}"
    elsif @movie[key].nil? || @movie[key] == ""
      cell.textLabel.text = "#{key} is blank"
    else
      cell.textLabel.text = "#{key}: #{@movie[key]}"
    end
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
    if @movie["images"]["poster_url"] != "NO POSTER"
      puts "selected movie -#{@movie["images"]["poster_url"]}"

      controller = PosterViewController.alloc.init
      controller.set_poster(@movie["images"]["poster_url"])
      #controller.setconfig(self.configuration_data)
      self.navigationController.pushViewController(controller, animated:true)
    end
  end
end
