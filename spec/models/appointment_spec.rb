require "rails_helper"

RSpec.describe Appointment, type: :model do
  let(:patient) { create(:patient) }
  let(:doctor)  { create(:doctor) }
  let(:start_time) { "2024-03-26 14:40" }
  let(:appointment) { build(:appointment, doctor:, patient:, start_time:) }

  describe "validations" do
    context "when start_time is valid" do
      it "is valid" do
        expect(appointment).to be_valid
      end
    end

    context "when start_time is in the past" do
      let(:start_time) { DateTime.now - 1.day }
      it "is not valid" do
        expect(appointment).to_not be_valid
        expect(appointment.errors.messages[:start_time]).to include("can't be in the past")
      end
    end

    context "when start_time is on a weekend" do
      let(:start_time) { DateTime.new(2024, 3, 24, 14, 40) }

      it "is not valid" do
        expect(appointment).to_not be_valid
        expect(appointment.errors.messages[:start_time]).to include("must be on working day")
      end
    end

    context "when start_time is outside of working hours" do
      let(:start_time) { DateTime.new(2024, 3, 26, 20, 15) }

      it "is not valid" do
        expect(appointment).to_not be_valid
        expect(appointment.errors.messages[:start_time]).to include("must be within working hours")
      end
    end

    context "when start_time is not on a 20 minute slot" do
      let(:start_time) { DateTime.new(2024, 3, 26, 14, 30) }

      it "is not valid" do
        expect(appointment).to_not be_valid
        expect(appointment.errors.messages[:start_time]).to include("must be in a slot")
      end
    end
  end
end
