import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="todo-list"
export default class extends Controller {
  static targets = ["form", "input"]

  connect() {
    console.log("Connected to todo-lis controller")
  }

  markComplete() {
    fetch(this.formTarget.action, {
      method: "PATCH",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
     },
      body: JSON.stringify({completed: this.inputTarget.checked})
    })
  }
}
