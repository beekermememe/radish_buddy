class SingleNetworkViewController < UIViewController
  def viewDidLoad
     super
     # Do any additional setup after loading the view.
   end

   def setup_poster
     if @network["logo"]
       img_v = UIImageView.alloc.initWithFrame([[0, 100], [320, 480]])
       img_v.url =  @network["logo"]
       view << img_v
     end
   end

   def setup_name_label
     if @network
       lbl = UILabel.alloc.initWithFrame([[0, 0], [320, 19]])
       lbl.text = @network["name"]
       view << lbl
     end
   end


   def set_network(network)
     @network = network
     setup_poster
     setup_name_label
   end

   def viewDidUnload
     super
     # Release any retained subviews of the main view.
   end

   def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
     interfaceOrientation == UIInterfaceOrientationPortrait
   end
end
