require "rails_helper"

RSpec.describe "Patients", type: :request do
  let!(:patients) { create_list(:patient, 6) }
  let!(:appointment) { create(:appointment, patient: patients.first) }
  subject(:request) { get patients_path }

  it "returns a successful response" do
    request
    expect(response).to have_http_status(:success)
  end

  it "returns all patients" do
    request
    expect(assigns(:patients)).to match_array(patients)
  end

  it "renders the index template" do
    request
    expect(response).to render_template(:index)
  end

  it "paginates patients" do
    request
    expect(assigns(:pagy)).to be_present
    expect(assigns(:patients).size).to eq(6)
  end

  context "when searching by last name" do
    let!(:patient) { create(:patient, last_name: "Patient") }
    subject(:request) { get "/patients", params: { q: { last_name_cont: "Patient" } } }

    it "returns a successful response" do
      request
      expect(response).to have_http_status(:success)
    end

    it "returns patients with last name Doe" do
      request
      expect(assigns(:patients)).to match_array([patient])
    end
  end

  context "when searching by gender" do
    let!(:patient) { create(:patient, gender: "Male") }
    subject(:request) { get patients_path, params: { q: { gender_eq: "Male" } } }

    it "returns a successful response" do
      request
      expect(response).to have_http_status(:success)
    end

    it "returns male patient" do
      request
      expect(assigns(:patients)).to match_array([patient])
    end
  end
end
