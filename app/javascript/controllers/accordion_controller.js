import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="accordion"
export default class extends Controller {
  static targets = ["item"]

  expand(event) {
    // this.itemTargets.forEach(item => item.classList.remove("active"))
    event.currentTarget.classList.toggle("active");
  }
}
