class AllNetworksViewController < UIViewController
  def viewDidLoad
    super
    @networks = []
#    Dispatch::Queue.concurrent('mc-data').async {
    Networks.get do |nws|
      update_networks(nws)
    end
#    }
  end

  def scrollViewDidScroll(scroll_view)
    page_width = scroll_view.frame.size.width
    page = ((scroll_view.contentOffset.x - page_width / 2) / page_width).floor + 1
    @page_control.currentPage = page
  end

  def update_networks(nws)
    @networks = nws
    set_networks(@networks)
  end

  def setup_poster(network,x_start)
    if !network["logo"].nil?
      img_v = UIImageView.alloc.initWithFrame([[x_start+90, 100], [140, 205]])
      img_v.url =  network["logo"]
      @scroll_view << img_v
    end
  end

  def setup_banner(network,x_start)
    if !network["banner"].nil?
      img_v = UIImageView.alloc.initWithFrame([[x_start, 306], [301, 83]])
      img_v.url =  network["banner"]
      @scroll_view << img_v
    end
  end
  def setup_name_label(network,x_start,count,total)
    if network
      lbl = UILabel.alloc.initWithFrame([[x_start, 0], [320, 19]])
      lbl.text = "#{network["name"]} (#{count} of #{total})"
      @scroll_view << lbl
    end
  end

  def setup_networks_label(network,x_start)
    if network
      lbl = UILabel.alloc.initWithFrame([[x_start, 20], [320, 39]])
      details = "#{network['url']}"
      lbl.text = details
      @scroll_view << lbl
    end
  end

  def add_network_view(network,index,count,total)
    x_start_index = index*320
    setup_poster(network,x_start_index)
    setup_banner(network,x_start_index)
    setup_name_label(network,x_start_index,count,total)
    setup_networks_label(network,x_start_index)
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
  def set_networks(networks)
    add_scroll_view(networks.count)
    add_page_control(networks.count)

    @networks = networks
    populate_posters(@networks)
  end

  def populate_posters(networks)
    index = 0
    total = networks.count
    networks.each do |network|
      add_network_view(network,index, index+1, total)
      index += 1
    end
  end
end