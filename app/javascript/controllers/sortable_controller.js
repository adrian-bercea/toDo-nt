import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"
import { put } from "@rails/request.js"

export default class extends Controller {
  // static values = { listId: Number }
  connect() {
    console.log("SortableController loaded")
    Sortable.create(this.element, {
      onEnd: this.onEnd.bind(this)
    })
  }
  

  onEnd(event) {
    console.log(event.item.dataset.sortableId)
    console.log(event.newIndex)
    console.log(`/lists/${event.item.dataset.sortableId}/sort`)
    put(`/lists/${event.item.dataset.sortableId}/sort`, {
      body: JSON.stringify({
        row_order_position: event.newIndex
      })
    })
  }
}