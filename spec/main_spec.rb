describe "Application 'radish_buddy'" do
  before do
    @app = UIApplication.sharedApplication
  end

  it "has one window" do
    @app.windows.size.should == 1
  end
end
