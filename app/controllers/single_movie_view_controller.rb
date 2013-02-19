class SingleMovieViewController < UIViewController
  def viewDidLoad
    super
    # Do any additional setup after loading the view.
    @movie_values_to_show = [
      "is_locked",
      "description",
      "is_parental_locked",
      "rating",
      "poster_url",
      "slug"
    ]
  end

  def setup_poster
    if @movie["images"]["poster_url"]
      img_v = UIImageView.alloc.initWithFrame([[0, 100], [320, 480]])
      img_v.url =  @movie["images"]["poster_url"]
      view << img_v
    end
  end

  def setup_name_label
    if @movie
      lbl = UILabel.alloc.initWithFrame([[0, 0], [320, 19]])
      lbl.text = @movie["name"]
      view << lbl
    end
  end

  def setup_networks_label
    if @movie
      lbl = UILabel.alloc.initWithFrame([[0, 20], [320, 39]])
      lbl.text = @movie["networks"].map{|n| n["name"]}.join(",")
      view << lbl
    end
  end
  def set_movie(movie)
    @movie = movie
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
