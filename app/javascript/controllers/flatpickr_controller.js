import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  connect() {
    flatpickr(".start_time", {
      dateFormat: "Y-m-d",
      minDate: "today",
      disable: [
        function (date) {
          return date.getDay() === 0 || date.getDay() === 6;
        },
      ],
      locale: {
        firstDayOfWeek: 1,
      },
    });
  }
}
