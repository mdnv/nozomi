require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

window.jQuery = $
window.$ = $

// BEGIN: Import images
require.context('../assets/images', true, /\.(jpg|png)$/i)
// END: Import images

// BEGIN: Apply theme
require('bootstrap')
require('metismenu')
require('jquery-slimscroll')
require('@themes/inspinia')

import 'bootstrap/dist/css/bootstrap.min.css'
import '../assets/stylesheets/staffs.scss'
// END: Apply theme

// BEGIN: Plugins
require('@plugins/fontawesome')
require('@plugins/toastr')
require('@plugins/bootstrap_select')
require('@plugins/bootstrap_datepicker')
require('@plugins/icheck')
require('@plugins/trix')
// END: Plugins

// BEGIN: Load stimulus
import { Application } from 'stimulus'
import { definitionsFromContext } from 'stimulus/webpack-helpers'

const application = Application.start()
const context = require.context('@controllers/staffs', true, /_controller\.js$/)
application.load(definitionsFromContext(context))
// END

$(document).on('turbolinks:load', () => {
  // Trim input
  $(document).on('change', 'input[type="text"]', (e) => {
    const value = $(e.currentTarget).val() || ''
    $(e.currentTarget).val(value.trim())
  })
  // Remove leading by 0
  $(document).on('change', 'input[data-field="number"]', (e) => {
    const value = (e.currentTarget.value || '').replace(/^0+(?=\d)/, '')
    e.currentTarget.value = value
  })
})
