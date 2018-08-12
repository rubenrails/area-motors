module EnquiriesHelper
  def options_for_status_select enquiry
    enquiry.aasm.states({:permitted => true}).map {|s| [s.name.to_s.titleize, s.name] }
  end
end
