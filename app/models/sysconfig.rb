class Sysconfig
  include Formotion::Formable
  attr_accessor :username, :user_uuid, :user_slingid, :server

  form_property :username, :picker, title: "Account", items: ["Lab_Full_Qa", "Lab_Medium_Qa", "Lab_Low_Qa", "Hunter"]
  form_property :server, :picker, title: "Radish Server", items: [
      "http://www.dishanywhere.com/radish/",
      "http://radish.dishanywhere.com/",
      "http://staging.dishanywhere.com/radish/",
      "http://staging-radish01.dishonline.com/",
      "http://int.dishanywhere.com/radish/",
      "http://int-radish01.dishonline.com/",
      "http://qa.dishanywhere.com/radish/",
      "http://qa-radish01.dishonline.com/"
    ]
  form_title "Select User and Radish Server"

  def initialize(username = "" ,server = "",source = nil)
    self
  end

private


end

module Formotion
  module RowType
    class PickerRow < StringRow

      def pickerView(pickerView, didSelectRow:index, inComponent:component)
        user_list = {
          "Lab_Full_Qa" => {
            username: "Lab_Full_Qa",
            sling_id: "",
            uuid: ""
          },
          "Lab_Medium_Qa" => {
            username: "Lab_Medium_Qa",
            sling_id: "",
            uuid: ""
          },
          "Lab_Low_Qa" => {
            username: "Lab_Low_Qa",
            sling_id: "",
            uuid: ""
          },
          "Hunter" => {
            username: "Hunter",
            sling_id: "",
            uuid: ""
          }
        }
        puts "cfg - #{$config}|"
        if value_for_name_index(index).include?("http")
          $config[:server_url]= value_for_name_index(index)
        else
          userdetails = user_list[value_for_name_index(index)] rescue {}
          $config[:username] =  userdetails[:username]
          $config[:sling_id] =  userdetails[:sling_id]
          $config[:uuid] =  userdetails[:uuid]
        end
        update_text_field(value_for_name_index(index))
      end
    end
  end
end