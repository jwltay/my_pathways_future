import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-form"
export default class extends Controller {
  static targets = ["secondbutton", "thirdbutton", "firstform", "secondform", "thirdform"]

  connect() {
    console.log("i am connected")
    this.secondbuttonTarget.addEventListener('click', this.secondPage.bind(this))
    this.thirdbuttonTarget.addEventListener('click', this.thirdPage.bind(this))
  }

  secondPage() {
    this.firstformTarget.classList.toggle('d-none')
    this.secondformTarget.classList.toggle('d-none')
  }

  thirdPage() {
    this.secondformTarget.classList.toggle('d-none')
    this.thirdformTarget.classList.toggle('d-none')
  }
}
