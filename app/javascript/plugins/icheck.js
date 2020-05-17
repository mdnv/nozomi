require('icheck')
import 'icheck/skins/square/green.css'

$(document).on('turbolinks:load', () => {
  $('.i-checks').iCheck({
    checkboxClass: 'icheckbox_square-green js-checkbox',
    radioClass: 'iradio_square-green js-radioButton'
  })
  $('.iCheck-helper').on('click', (e) => {
    const event = document.createEvent("MouseEvents");
    event.initEvent('click', true, true);
    e.currentTarget.closest('label').dispatchEvent(event);
  })
})
