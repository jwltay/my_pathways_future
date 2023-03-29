import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="todo-list"
export default class extends Controller {
  static targets = ["form", "checkbox", "input"];

  connect() {
    console.log("Connected to todo-list controller");
  }

  markComplete() {
    fetch(this.formTarget.action, {
      method: "PATCH",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ completed: this.checkboxTarget.checked }),
    });

    if (this.checkboxTarget.classList.contains("is-valid")) {
      this.checkboxTarget.classList.remove("is-valid");
    } else {
      this.checkboxTarget.classList.add("is-valid");
    }
  }

  addTask() {
    console.log("Add task!");
  }
}
