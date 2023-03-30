import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="todo-list"
export default class extends Controller {
  static targets = ["checkboxForm", "taskForm", "checkbox", "items", "delete"];
  static values = { position: String }

  connect() {
    console.log("Connected to todo-list controller");
  }

  markComplete() {
    fetch(this.checkboxFormTarget.action, {
      method: "PATCH",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ completed: this.checkboxTarget.checked })
    });

    if (this.checkboxTarget.classList.contains("is-valid")) {
      this.checkboxTarget.classList.remove("is-valid");
    } else {
      this.checkboxTarget.classList.add("is-valid");
    }
  }

  addTask(e) {
    e.preventDefault();
    fetch(this.taskFormTarget.action, {
      method: "POST",
      headers: {
        Accept: "application/json"
      },
      body: new FormData(this.taskFormTarget)
    })
      .then(response => response.json())
      .then((data) => {
        if (data.inserted_item) {
          this.itemsTarget.insertAdjacentHTML(this.positionValue, data.inserted_item)
        }
        const action = this.taskFormTarget.action
        this.taskFormTarget.outerHTML = data.form
        this.taskFormTarget.action = action
      })
  }

  deleteTask(e) {
    e.preventDefault();
    console.log(e.detail.url.href)
    fetch(e.detail.url.href, {
      method: "DELETE"
    })
      .then(response => {
        console.log(response)
      })
  }
}
