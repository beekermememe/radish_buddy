class PosterViewController < UIViewController

  def viewDidLoad
    super
    # Uncomment the following line to preserve selection between presentations.

    # self.clearsSelectionOnViewWillAppear = false

    # Uncomment the following line to display an Edit button in the navigation
    # bar for this view controller.

    # self.navigationItem.rightBarButtonItem = self.editButtonItem
    @posterurl = nil
  end

  def viewDidUnload
    super

    # Release any retained subviews of the main view.
    # e.g. self.myOutlet = nil
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end

## Table view data source

  def set_poster(posterurl)
    begin
      @posterurl = posterurl
      image_view = UIImageView.alloc.initWithFrame CGRectMake(0, 0, 320, 480)
      image_view.url = @posterurl
      view.addSubview(image_view)
    rescue Exception => e
      puts "\n #{e.message} -- \n #{e.backtrace}"
    end

  end
  # To change this template use File | Settings | File Templates.
end