class EnquiriesController < ApplicationController

  def index
    @enquiries = Enquiry.all
  end

  def show
    @enquiry = Enquiry.find params[:id]
  end

  def load
    new_enquiries_params = EnquiryParser.call
    Enquiry.create! new_enquiries_params

    if new_enquiries_params.empty?
      redirect_to root_url, flash: { alert: "We couldn't find any new enquiries." }
    else
      redirect_to root_url, flash: { notice: "We've found #{new_enquiries_params.size} new enquiries. You can see them listed below." }
    end
  end
end
