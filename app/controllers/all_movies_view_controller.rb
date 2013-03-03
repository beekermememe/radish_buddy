class AllMoviesViewController < UIViewController
  def viewDidLoad
    super
    @movies = []
#    Dispatch::Queue.concurrent('mc-data').async {
      Movies.get do |mvs|
        update_movies(mvs)
      end
#    }
  end

  def scrollViewDidScroll(scroll_view)
    page_width = scroll_view.frame.size.width
    page = ((scroll_view.contentOffset.x - page_width / 2) / page_width).floor + 1
    @page_control.currentPage = page
  end

  def update_movies(mvs)
    @movies = mvs
    set_movies(@movies)
  end

  def setup_poster(movie,x_start)
    if !movie["images"].nil? && !movie["images"]["poster_url"].nil?
      img_v = UIImageView.alloc.initWithFrame([[x_start, 100], [320, 480]])
      img_v.url =  movie["images"]["poster_url"]
      @scroll_view << img_v
    end
  end

  def setup_name_label(movie,x_start)
    if movie
      lbl = UILabel.alloc.initWithFrame([[x_start, 0], [320, 19]])
      lbl.text = movie["name"]
      @scroll_view << lbl
    end
  end

  def setup_networks_label(movie,x_start)
    if movie
      lbl = UILabel.alloc.initWithFrame([[x_start, 20], [320, 39]])
      network = movie["networks"].map{|n| n["name"]}.join(",")
      rating = movie['rating'].to_s == "" ? "No rating" : movie['rating']
      details = "#{network} - #{rating}"
      lbl.text = details
      @scroll_view << lbl
    end
  end

  def add_movie_view(movie,index)
    x_start_index = index*320
    setup_poster(movie,x_start_index)
    setup_name_label(movie,x_start_index)
    setup_networks_label(movie,x_start_index)
  end

  def add_scroll_view(number_of_pages)
    @scroll_view = UIScrollView.alloc.initWithFrame([[0,0], [320,480]])
    @scroll_view.contentSize = CGSizeMake(320*number_of_pages, 480)
    @scroll_view.pagingEnabled = true
    @scroll_view.delegate = self
    view << @scroll_view
  end

  def add_page_control(number_of_pages)
    @page_control = UIPageControl.alloc.initWithFrame([[110,340], [100,20]])
    @page_control.numberOfPages = number_of_pages
    view << @page_control
  end
  def set_movies(movies)
    add_scroll_view(movies.count)
    add_page_control(movies.count)

    @movies = movies
    populate_posters(@movies)
  end

  def populate_posters(movies)
    index = 0
    movies.each do |movie|
      add_movie_view(movie["movie"],index)
      index += 1
    end
  end
end