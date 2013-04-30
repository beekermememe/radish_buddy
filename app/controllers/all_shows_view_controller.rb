class AllShowsViewController < UIViewController
  def viewDidLoad
    super
    @show = []
#    Dispatch::Queue.concurrent('mc-data').async {
      Shows.get do |shs|
        update_shows(shs)
      end
#    }
  end

  def scrollViewDidScroll(scroll_view)
    page_width = scroll_view.frame.size.width
    page = ((scroll_view.contentOffset.x - page_width / 2) / page_width).floor + 1
    @page_control.currentPage = page
  end

  def update_shows(shs)
    @shows = shs
    set_shows(@shows)
  end

  def setup_poster(show,x_start)
    if !show["images"].nil? && !show["images"]["poster_url"].nil?
      img_v = UIImageView.alloc.initWithFrame([[x_start, 100], [170, 240]])
      img_v.url =  show["images"]["poster_url"]
      @scroll_view << img_v
    end
  end

  def setup_name_label(show,x_start)
    if show
      lbl = UILabel.alloc.initWithFrame([[x_start, 0], [320, 19]])
      lbl.text = show["name"]
      @scroll_view << lbl
    end
  end

  def setup_networks_label(show,x_start)
    if show
      lbl = UILabel.alloc.initWithFrame([[x_start, 20], [320, 39]])
      network = show["networks"].map{|n| n["name"]}.join(",")
      rating = show['rating'].to_s == "" ? "No rating" : show['rating']
      details = "#{network} - #{rating}"
      lbl.text = details
      @scroll_view << lbl
    end
  end

  def add_show_view(show,index)
    x_start_index = index*320
    setup_poster(show,x_start_index)
    setup_name_label(show,x_start_index)
    setup_networks_label(show,x_start_index)
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
  def set_shows(shows)
    add_scroll_view(shows.count)
    add_page_control(shows.count)

    @shows = shows
    populate_posters(@shows)
  end

  def populate_posters(shows)
    index = 0
    shows.each do |show|
      add_show_view(show["show"],index)
      index += 1
    end
  end
end