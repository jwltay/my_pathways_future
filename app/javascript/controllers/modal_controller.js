import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["popup"]

  connect() {
    // console.log(this.popupTarget);
  }

  showModal() {
    this.popupTarget.classList.add("show")
    window.addEventListener("keyup", this.keyDispatcher.bind(this))
  }

  hideModal() {
    this.popupTarget.classList.remove("show")
    window.removeEventListener("keyup", this.keyDispatcher)
  }

  keyDispatcher(e) {
    if (e.key == "Escape") {
      this.hideModal()
    }
  }
}
