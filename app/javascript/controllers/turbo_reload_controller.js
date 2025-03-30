import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Turbo Reload Controller connected")
    this.handleReload = this.handleReload.bind(this)
    document.addEventListener("turbo:before-stream-render", this.handleReload)
  }
  
  disconnect() {
    document.removeEventListener("turbo:before-stream-render", this.handleReload)
  }
  
  handleReload(event) {
    console.log("Handling stream event", event)
    if (event.target.action === "reload") {
      event.preventDefault()
      
      // Find the turbo-frame element
      const frame = document.getElementById("lists-content")
      if (frame) {
        console.log("Reloading frame")
        // Get the current URL
        const currentUrl = window.location.href
        
        // Visit the current URL again via the frame
        frame.setAttribute("src", currentUrl)
        
        // Force the frame to reload
        frame.reload()
      } else {
        console.log("Frame not found, falling back to page reload")
        window.location.reload()
      }
    }
  }
}