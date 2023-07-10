import { Controller } from "@hotwired/stimulus";
import debounce from "https://cdn.jsdelivr.net/npm/debounce@1.2.1/+esm";

export default class extends Controller {
  connect() {
    this.submit = debounce(this.submit.bind(this), 200);
  }

  submit(_event) {
    this.element.requestSubmit();
  }
}
