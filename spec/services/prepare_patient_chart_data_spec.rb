require "rails_helper"

RSpec.describe Charts::Services::PreparePatientChartData, type: :service do
  let(:patient) { create_list(:patient, 10, date_of_birth: "1999-02-24") }
  subject(:call) { described_class.call }

  describe "#call" do
    context "when there are no patients" do
      it "returns nil" do
        expect(call).to be_nil
      end
    end

    context "when there are patients" do
      before do
        patient
      end

      it "returns a hash" do
        expect(call).to be_a(Hash)
      end

      it "returns a hash with keys as years and values as counts" do
        expect(call).to eq({ Time.parse("1999-01-01 00:00:00.000000000 +0000") => 10 })
      end
    end
  end
end
