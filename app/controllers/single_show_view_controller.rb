class SingleShowViewController < UIViewController
  def viewDidLoad
    super
    # Do any additional setup after loading the view.
    @show_values_to_show = [
      "is_locked",
      "description",
      "is_parental_locked",
      "rating",
      "poster_url",
      "slug"
    ]
  end

  def setup_poster
    if @show["images"]["poster_url"]
      img_v = UIImageView.alloc.initWithFrame([[0, 100], [320, 480]])
      img_v.url =  @show["images"]["poster_url"]
      view << img_v
    end
  end

  def setup_name_label
    if @show
      lbl = UILabel.alloc.initWithFrame([[0, 0], [320, 19]])
      lbl.text = @show["name"]
      view << lbl
    end
  end

  def setup_networks_label
    if @show
      lbl = UILabel.alloc.initWithFrame([[0, 20], [320, 39]])
      lbl.text = @show["networks"].map{|n| n["name"]}.join(",")
      view << lbl
    end
  end
  def set_show(show)
    @show = show
    setup_poster
    setup_name_label
    setup_networks_label
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
end
