import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="draft-pick"
export default class extends Controller {
  connect() {
    console.log("Draft pick controller connected!")
  }

  // connects to the make draft pick button in the draft pick form
  makePick(event) {
    event.preventDefault()
    console.log("makePick() called")
    this.element.submit()
  }
}
