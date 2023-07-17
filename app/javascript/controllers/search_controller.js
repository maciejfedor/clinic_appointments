import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.submit = this.submit.bind(this);
  }

  submit(_event) {
    this.element.requestSubmit();
  }
}
