import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="accordion"
export default class extends Controller {
  static targets = ["panel"]

  expand(event) {
    event.currentTarget.nextElementSibling.classList.toggle('active')
  }
}
