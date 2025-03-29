import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"
import { put } from "@rails/request.js"

export default class extends Controller {
  static values = { group: String }
  connect() {
    console.log("SortableController loaded")
    Sortable.create(this.element, {
      onEnd: this.onEnd.bind(this),
      group: this.groupValue
    })
  }
  

  onEnd(event) {
    var sortableUrl = event.item.dataset.sortableUrl
    var sortableListId = event.to.dataset.sortableListId
    // console.log(sortableUrl)
    // console.log(sortableListId)
    put(sortableUrl, {
      body: JSON.stringify({
        row_order_position: event.newIndex,
        list_id: sortableListId
      })
    })
  }
}