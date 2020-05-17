require("trix")
require("@rails/actiontext")
import 'trix/dist/trix.css'
import '../assets/stylesheets/plugins/actiontext.scss'

$(document).on('turbolinks:load', () => {
  // Remove attach files button
  $('.trix-button-group--file-tools').remove()
})
