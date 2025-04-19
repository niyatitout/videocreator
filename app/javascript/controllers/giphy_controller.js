// app/javascript/controllers/giphy_controller.js
import { Controller } from "@hotwired/stimulus"
import Giphy from 'giphy-api';

export default class extends Controller {
  static targets = ["results", "input"]
  static values = { apiKey: String }

  connect() {
    this.giphy = Giphy({ apiKey: this.apiKeyValue || 'YOUR_GIPHY_API_KEY' })
  }

  search() {
    const query = this.inputTarget.value
    if (query.length < 2) return
    
    this.giphy.search({
      q: query,
      limit: 10,
      rating: 'g'
    }, (err, res) => {
      this.resultsTarget.innerHTML = res.data.map(gif => `
        <img src="${gif.images.fixed_height.url}" 
             class="cursor-pointer" 
             data-action="click->giphy#selectGif">
      `).join('')
    })
  }

  selectGif(event) {
    const gifUrl = event.currentTarget.src
    // You might want to send this to your server or handle it differently
    console.log("Selected GIF:", gifUrl)
  }
}