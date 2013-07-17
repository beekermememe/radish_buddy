class UserParentalControlsViewController < UIViewController

  def viewDidLoad
    super
  end

  def update_data(user)
    sv = UIScrollView.alloc.initWithFrame([[0,0],[320,480]])
    sv.scrollEnabled = true
    view << sv
    next_starting_point = 0
    parental_controls_data = user[0]['parental_controls_data']
    user[0]['parental_controls_data'].each do |k|
      puts("\n data #{k.flatten[0]} = #{k.flatten[1]}")
      next_starting_point = add_summary_info(k,next_starting_point,sv)
    end
  end

  def add_summary_info(data,next_starting_point,scroll_vw)
    return next_starting_point if data.flatten[1] == 'TODO'
    lbl = UILabel.alloc.init
    lbl.frame = [[0,next_starting_point],[320,20]]
    lbl.text = "#{data.flatten[0].to_s.gsub('_',' ').capitalize} =>"
    lbl.font = :bold.uifont(:small)
    scroll_vw << lbl
    lbl_height = 100
    lbl_height = 20 unless data.flatten[0] == 'unlocked_network_ids'
    lbl = UILabel.alloc.init
    lbl.frame = [[0,next_starting_point + 20],[320,lbl_height]]
    lbl.text = "  #{data.flatten[1]}"
    lbl.font = :bold.uifont(:small)
    lbl.numberOfLines = 6
    lbl.lineBreakMode = true
    scroll_vw << lbl
    return next_starting_point + 20 + lbl_height
  end

end