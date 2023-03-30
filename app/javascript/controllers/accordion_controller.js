import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="accordion"
export default class extends Controller {
  static targets = ["program"]

  expand(event) {
    event.currentTarget.parentNode.classList.toggle("active");
  }
}
