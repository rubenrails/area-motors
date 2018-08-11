require 'rails_helper'

RSpec.describe EnquiriesController, type: :controller do
  render_views

  describe "GET #index" do
    let(:enquiry){ create(:enquiry) }
    let(:all_enquiries) { Enquiry.new_status_first.oldest_first }

    it "returns http success" do
      get :index
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "assigns @enquiries" do
      get :index
      expect(assigns(:enquiries)).to match_array all_enquiries
    end
  end

  describe 'GET #show' do
    let(:enquiry){ create(:enquiry) }

    it "returns http success" do
      get :show, params: { id: enquiry.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns @enquiry" do
      get :show, params: { id: enquiry.id }
      expect(assigns(:enquiry)).to eq enquiry
    end
  end

  describe 'GET #load' do
    before(:each) do
      stub_const "#{EnquiryParser}::SOURCE_DIR", Rails.root.join("spec", "fixtures")
    end

    context 'when there are new enquiries to be parsed' do
      let(:message) { "We've found 2 new enquiries. You can see them listed below." }
      it 'parses new enquires and saves them to the database' do
        expect {
          get :load
        }.to change{Enquiry.count}.by(2)
      end

      it 'notifies the user that new enquiries were created' do
        get :load
        expect(controller).to set_flash[:notice].to(message)
      end

      it 'redirects to root_path' do
        get :load
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when there arent new enquiries' do
      let(:enquiry_parser) { instance_double(EnquiryParser) }
      let(:message) {"We couldn't find any new enquiries." }

      before(:each) do
        allow(EnquiryParser).to receive(:new).and_return(enquiry_parser)
        allow(enquiry_parser).to receive(:call).and_return []
      end

      it 'does not create any new enquiries' do
        expect {
          get :load
        }.to_not change{Enquiry.count}
      end

      it 'notifies the user that there are no new enquiries to parse' do
        get :load
        expect(controller).to set_flash[:alert].to(message)
      end

      it 'redirects to root_path' do
        get :load
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH #update' do
    let!(:enquiry){ create(:enquiry) }
    let(:params) do
      {
        id: enquiry.id,
        enquiry: {
          status: 'done'
        }
      }
    end

    it { is_expected.to permit(:status).for(:update, params: params).on(:enquiry) }

    it 'redirects to enquiry#show' do
      patch :update, params: params
      expect(response).to redirect_to(enquiry_path(enquiry))
    end
  end
end
