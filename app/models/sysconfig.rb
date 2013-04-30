class Sysconfig
  include Formotion::Formable
  attr_accessor :username, :user_uuid, :user_slingid, :server

  form_property :username, :picker_with_done, title: "Account", items: ["Lab_Full_Qa", "Lab_Medium_Qa", "Lab_Low_Qa", "Hunter"]
  form_property :server, :picker_with_done, title: "Radish Server", items: [
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
    class PickerWithDoneRow < PickerRow
      include RowType::ItemsMapper

      def after_build(cell)
        super
        keyboardDoneButtonView             = UIToolbar.new
        keyboardDoneButtonView.barStyle    = UIBarStyleBlack
        keyboardDoneButtonView.translucent = true
        keyboardDoneButtonView.tintColor   = nil
        keyboardDoneButtonView.sizeToFit

        doneButton = UIBarButtonItem.alloc.initWithTitle("Done", style:UIBarButtonItemStyleDone,  target:self, action: 'picker_done_clicked')
        spacer1    = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemFlexibleSpace, target:self, action: nil)
        spacer     = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemFlexibleSpace, target:self, action: nil)
        keyboardDoneButtonView.setItems([spacer, spacer1, doneButton])

        row.text_field.inputAccessoryView = keyboardDoneButtonView
      end

      def picker_done_clicked
        # 'jump' to next input field if one exists
        if row.next_row && row.next_row.text_field
          row.next_row.text_field.becomeFirstResponder
        else
          # just hide the keyboard...
          row.text_field.resignFirstResponder
        end
      end
    end

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


module Formotion
  module RowType

  end
end