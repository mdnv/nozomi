require('bootstrap-select')
import 'bootstrap-select/dist/css/bootstrap-select.min.css'

$(document).on('turbolinks:load', () => {
  // Build selectpicker
  $('.selectpicker').selectpicker({
    hideDisabled: true
  })

  // Reset form and selectpicker when click `Reset` button
  $(document.body).on('click', 'input[type="reset"]', (e) => {
    $(e.currentTarget).closest('form').trigger('reset')
    $('.selectpicker').selectpicker('refresh')
  })
})

$(document).on('turbolinks:before-cache', () => {
  $('.selectpicker').selectpicker('destroy').addClass('selectpicker')
})
