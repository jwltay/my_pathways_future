import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="read-more"
export default class extends Controller {
  static targets = ["triggerMore", "triggerLess"]

  readMore(e) {
    e.preventDefault()
    this.triggerLessTarget.classList.add('active')
    e.currentTarget.closest("span").classList.remove('active')
    e.currentTarget.parentElement.closest('div').classList.add('show-item')
  }

  readLess(e) {
    e.preventDefault()
    this.triggerLessTarget.classList.remove('active')
    e.currentTarget.closest("span").classList.remove('active')
    this.triggerMoreTarget.classList.add('active')
    e.currentTarget.parentElement.closest('div').classList.remove('show-item')
  }
}
