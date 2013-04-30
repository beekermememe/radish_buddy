class SingleNetworkViewController < UIViewController
  def viewDidLoad
    view.backgroundColor = :gray.uicolor
    super
    # Do any additional setup after loading the view.
   end

  def setup_poster
   if @network["logo"]
     img_v = UIImageView.alloc.initWithFrame([[0, 100], [140, 105]])
     img_v.url =  @network["logo"]
     view << img_v
   end
  end

  def setup_lock_unlock
   locked_view = UIImageView.alloc.initWithFrame([[160, 100], [20, 20]])
   if @network['is_locked'] == true || @network['is_locked'] == "true"
     locked_view.image = "padlock-icon-hi".uiimage
   else
     locked_view.image =  "unlocked".uiimage
   end
   view << locked_view
  end

  def setup_name_label
   if @network
     lbl = UILabel.alloc.initWithFrame([[0, 0], [320, 19]])
     lbl.text = @network["name"]
     view << lbl
   end
  end

  def setup_counts_label
    if @network
      lbl = UILabel.alloc.initWithFrame([[0, 25], [320, 44]])
      lbl.text = @network["name"]
      view << lbl
    end
  end

  def set_network(network)
   @network = network
   setup_poster
   setup_name_label
   setup_lock_unlock
  end

  def viewDidUnload
   super
   # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
   interfaceOrientation == UIInterfaceOrientationPortrait
  end
end
