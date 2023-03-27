import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="shortlist"
export default class extends Controller {
  connect() {
    console.log("It's connected!");
  }

  update(e) {
    e.preventDefault();

    const target = e.currentTarget;
    const url = target.action;

    fetch(url, {
      method: "post",
      headers: {
        Accept: "text/plain",
      },
      body: new FormData(target),
    })
      .then(res => res.text())
      .then(data => {
        target.outerHTML = data;
      });
  }
}
