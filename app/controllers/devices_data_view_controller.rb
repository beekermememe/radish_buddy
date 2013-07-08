class DevicesDataViewController < UIViewController

  def viewDidLoad
    super
  end

  def update_data(user)
    @sv = UIScrollView.alloc.initWithFrame([[0,0],[320,480]])
    @sv.scrollEnabled = true
    @sv.showsVerticalScrollIndicator = true
    @sv.pagingEnabled = true
    @sv.delegate = self

    next_starting_point = 0
    user[2]['devices_data'].each do |k|
      next_starting_point = add_device_info(k,next_starting_point,@sv)
    end
    @sv.contentSize = CGSizeMake(320,next_starting_point)
    view << @sv

    add_page_control( (next_starting_point/480).to_i + 1 )
  end

  def add_device_info(data,next_starting_point,scroll_vw)
    lbl = UILabel.alloc.init
    lbl.frame = [[0,next_starting_point],[320,20]]
    lbl.text = "DEVICE"
    lbl.font = :bold.uifont
    scroll_vw << lbl
    next_starting_point = next_starting_point + 20
    data.each do |k,v|
      next if v.to_s == '' || v.nil?
      lbl = UILabel.alloc.init
      lbl.frame = [[0,next_starting_point],[320,20]]
      lbl.text = "   #{k.to_s.gsub('_',' ').capitalize}"
      lbl.font = :bold.uifont(:small)
      scroll_vw << lbl
      lbl_height = 20
      lbl = UILabel.alloc.init
      lbl.frame = [[0,next_starting_point + 20],[320,lbl_height]]
      lbl.text = "      #{v}"
      lbl.font = :small.uifont
      scroll_vw << lbl
      next_starting_point = next_starting_point + 20 + lbl_height
    end
    return next_starting_point
  end

  def scrollViewDidScroll(scroll_view)
    page_height = scroll_view.frame.size.height
    page = ((scroll_view.contentOffset.y - page_height / 2) / page_height).floor + 1
    @page_control.currentPage = page
  end

  def add_page_control(number_of_pages)
    @page_control = UIPageControl.alloc.initWithFrame([[110,340], [100,20]])
    @page_control.numberOfPages = number_of_pages
    view << @page_control
  end
end