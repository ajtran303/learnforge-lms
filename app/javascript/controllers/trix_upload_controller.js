import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.restrictToImages()
  }

  restrictToImages() {
    this.element.addEventListener("trix-file-accept", (event) => {
      const file = event.file
      if (!file.type.startsWith("image/")) {
        event.preventDefault()
        alert("Only images are allowed")
      }
    })
  }
}
