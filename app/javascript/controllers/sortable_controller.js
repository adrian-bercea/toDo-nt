import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"
import { put } from "@rails/request.js"

export default class extends Controller {
  static values = { listId: Number }
  
  connect() {
    console.log("Sortable connected for list:", this.listIdValue)
    this.createSortable()
  }
  
  disconnect() {
    if (this.sortable) {
      this.sortable.destroy()
      this.sortable = null
    }
  }
  
  createSortable() {
    if (this.sortable) this.sortable.destroy()
    
    // Add a small delay to ensure DOM is fully ready
    setTimeout(() => {
      if (!this.element) return
      
      this.sortable = Sortable.create(this.element, {
        group: "tasks",
        animation: 150,
        fallbackOnBody: true,
        swapThreshold: 0.65,
        onEnd: this.handleSortEnd.bind(this)
      })
    }, 10)
  }
  
  handleSortEnd(event) {
    if (event.from === event.to && event.oldIndex === event.newIndex) return
    
    const item = event.item
    const newPosition = event.newIndex + 1
    const url = item.dataset.sortableUrl
    const newListId = parseInt(event.to.closest('[data-sortable-list-id-value]').dataset.sortableListIdValue)
    
    console.log(`Moving to list ${newListId}, position ${newPosition}`)
    
    // Update the data-list-id attribute to match the new list
    item.dataset.listId = newListId
    
    put(url, { 
      body: JSON.stringify({ position: newPosition, list_id: newListId }),
      responseKind: "json"
    })
  }
}