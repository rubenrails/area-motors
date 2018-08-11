class EnquiriesController < ApplicationController

  def index
    @enquiries = Enquiry.new_status_first.oldest_first
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

  def update
    @enquiry = Enquiry.find params[:id]
    begin @enquiry.update enquiry_params
      redirect_to @enquiry, notice: "The status was successfully updated."
    rescue ArgumentError # enum raises this error on invalid status
      flash.now[:alert] = "We couldn't update the status. Please try again."
      render :show
    end
  end

  def search
    query = params[:query]&.downcase
    if query.blank?
      redirect_to(root_url, flash: { alert: "Please enter a search term." }) and return
    else
      @enquiries = Enquiry.search(params[:query]).new_status_first.oldest_first
      flash.now[:notice] = "Found #{@enquiries.count} results for #{query}"
      render :index
    end
  end

  private
  def enquiry_params
    params.require(:enquiry).permit(:status)
  end
end
