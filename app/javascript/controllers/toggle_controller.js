import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["input1", "input2", "output", "select"];

  connect() {
    this.show();
  }

  show() {
    const shouldHideOutput =
      (this.input1Target.value === "" && this.input2Target.value === "") ||
      (this.input1Target.value === "" && this.input2Target.value !== "");
    const shouldShowOutput =
      this.input1Target.value !== "" && this.input2Target.value !== "";

    if (shouldHideOutput) {
      this.outputTarget.hidden = true;
    } else if (shouldShowOutput) {
      this.outputTarget.hidden = false;
      this.fetchAvailableSlots();
    }
  }

  async fetchAvailableSlots() {
    const doctorId = this.input1Target.value;
    const appointmentDate = this.input2Target.value;

    const response = await fetch(
      `/appointments/available_slots?doctor_id=${doctorId}&appointment_date=${appointmentDate}`
    );
    const slots = await response.json();

    this.updateSelectOptions(slots);
    this.setOutputValue(slots);
  }

  clearSelectOptions() {
    this.selectTarget.innerHTML = "";
  }

  updateSelectOptions(slots) {
    this.clearSelectOptions();

    const options = slots.map((slot) => {
      return `<option value="${slot}">${slot}</option>`;
    });

    this.selectTarget.innerHTML = options.join("");
  }

  setOutputValue(slots) {
    this.outputTarget.dataset.slotsValue = JSON.stringify(slots);
  }
}
