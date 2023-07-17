require "rails_helper"

RSpec.describe Appointments::Services::CalculateAvailableSlots, type: :service do
  let(:doctor) { create(:doctor) }
  subject(:call) { described_class.call(doctor_id: doctor.id, appointment_date: "2023-07-20 08:00") }

  describe "#call" do
    context "when there are no appointments" do
      it "returns an array of 24 slots" do
        expect(call.size).to eq(24)
      end
    end

    context "when there are appointments" do
      before do
        create(:appointment, doctor:, start_time: "2023-07-20 08:20")
        create(:appointment, doctor:, start_time: "2023-07-20 08:40")
        create(:appointment, doctor:, start_time: "2023-07-20 09:00")
        create(:appointment, doctor:, start_time: "2023-07-20 10:00")
      end

      it "returns an array of 12 slots" do
        expect(call.size).to eq(20)
      end

      it "returns an array of slots without appointments" do
        expect(call).not_to include(["08:20", "08:40", "09:00", "10:00"])
      end
    end
  end
end
