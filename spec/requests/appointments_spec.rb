require "rails_helper"

RSpec.describe "Appointments", type: :request do
  let(:patient) { create(:patient) }
  let(:doctor) { create(:doctor) }
  let!(:appointments) { create_list(:appointment, 4, :with_random_start_time, patient:, doctor:) }

  describe "GET /appointments" do
    subject(:request) { get all_appointments_path }

    it "returns a successful response" do
      request
      expect(response).to have_http_status(:success)
    end

    it "returns all appointments" do
      request
      expect(assigns(:appointments)).to match_array(appointments)
    end

    it "renders the index template" do
      request
      expect(response).to render_template(:index)
    end
  end

  describe "GET /patients/:patient_id/appointments" do
    let(:patient_2) { create(:patient, first_name: "John") }
    let!(:appointment) { create(:appointment, patient: patient_2, doctor:) }
    subject(:request) { get patient_appointments_path(patient_2) }

    it "returns a successful response" do
      request
      expect(response).to have_http_status(:success)
    end

    it "returns all appointments for a patient" do
      request
      expect(assigns(:appointments)).to eq([appointment])
    end

    it "renders the index template" do
      request
      expect(response).to render_template(:index)
    end
  end

  describe "GET /appointments/new" do
    subject(:request) { get new_patient_appointment_path(patient) }

    it "returns a successful response" do
      request
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      request
      expect(response).to render_template(:new)
    end
  end

  describe "POST /patients/:patient_id/appointments" do
    subject(:request) { post patient_appointments_path(patient), params: }

    context "with valid params" do
      let(:params) do
        {
          appointment: {
          doctor_id: doctor.id,
          price: 100,
          date: "2024-03-26",
          slot: "14:40",
        }
      }
      end

      it "creates a new appointment" do
        expect { request }.to change(Appointment, :count).by(1)
      end

      it "redirects to all appointments" do
        request
        expect(response).to redirect_to(all_appointments_path)
      end

      it "sets a flash message" do
        request
        expect(flash[:success]).to eq("Appointment created successfully!")
      end
    end

    context "with invalid params" do
      let(:params) do
        {
          appointment: {
            doctor_id: doctor.id,
            price: -100,
            date: "2024-03-26",
            slot: "",
          },
        }
      end

      it "does not create a new appointment" do
        expect { request }.not_to change(Appointment, :count)
      end

      it "renders the new template" do
        request
        expect(response).to render_template(:new)
      end
    end
  end
end
