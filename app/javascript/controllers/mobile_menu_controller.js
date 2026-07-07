import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "button"]

  connect() {
    this.clickHandler = this.closeOnClickOutside.bind(this)
  }

  toggle() {
    this.menuTarget.classList.toggle("hidden")
    if (this.menuTarget.classList.contains("hidden")) {
      document.removeEventListener("click", this.clickHandler)
    } else {
      document.addEventListener("click", this.clickHandler)
    }
  }

  close(event) {
    if (event.target.closest("a") || event.target.closest("button[type='submit']")) {
      this.menuTarget.classList.add("hidden")
      document.removeEventListener("click", this.clickHandler)
    }
  }

  closeOnClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden")
      document.removeEventListener("click", this.clickHandler)
    }
  }
}
