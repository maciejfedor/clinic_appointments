require "rails_helper"

RSpec.describe "Chart", type: :request do
  let(:patients) { create_list(:patient, 10) }

  describe "GET /chart" do
    subject(:request) { get chart_path }

    before do
      allow(Charts::Services::PreparePatientChartData).to receive(:call).and_return({
                                                                                      "1990" => 10, "2000" => 20
                                                                                    })
    end

    it "returns a successful response" do
      request
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end
end
