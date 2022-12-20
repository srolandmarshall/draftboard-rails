import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="draft-pick"
export default class extends Controller {
  connect() {
    console.log("Draft pick controller connected!")
  }

  // on click, console log the element that was clicked
  pick(event) {
    console.log("Button clicked!", event.target)
  }
}
