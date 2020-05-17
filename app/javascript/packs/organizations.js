require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

window.jQuery = $
window.$ = $

// BEGIN: Import toastr
import toastr from 'toastr';

toastr.options = {
  'closeButton': true,
  'positionClass': 'toast-top-right',
  'preventDuplicates': false,
  'onclick': null,
  'showDuration': '1000',
  'hideDuration': '0',
  'timeOut': '5000',
  'showEasing': 'swing',
  'hideEasing': 'linear',
  'showMethod': 'fadeIn',
  'hideMethod': 'fadeOut'
}
window.toastr = toastr
// END: Import toastr

// BEGIN: Import fontawesome svg
import { library, dom } from '@fortawesome/fontawesome-svg-core'
import {
  faBars, faSignOutAlt, faTimes, faChevronUp, faHome,faUser,faArchive,faCheckSquare,
  faBuilding,faUserCircle,faIdCardAlt,faCog,faTrash,faFilter
} from '@fortawesome/free-solid-svg-icons'

library.add(
  faBars, faSignOutAlt, faHome, faTimes, faChevronUp,faUser,faArchive,faCheckSquare,
  faBuilding,faUserCircle,faIdCardAlt,faCog,faTrash,faFilter
)
dom.watch()
// END: Import fontawesome svg

// BEGIN: Import Inspinia Stylesheets
import 'bootstrap/dist/css/bootstrap.min.css'
import 'toastr/toastr.scss'
import '../assets/stylesheets/organizations.scss'
// END: Import Inspinia Stylesheets

// BEGIN: Import Inspinia Javascript
require('bootstrap')
require('metismenu')
require('jquery-slimscroll')
require('@themes/inspinia')
// END: Import Inspinia Javascript

// BEGIN: Import images
require.context('../assets/images', true, /\.(jpg|png)$/i)
// END: Import images

// BEGIN: Addition
require('bootstrap-datepicker')

const DATE_FORMATS = {
  vi: 'dd/mm/yyyy',
  ja: 'yyyy/mm/dd',
  en: 'mm/dd/yyyy'
}

$(document).on('turbolinks:load', () => {
  // Setting datepicker format
  const currentLanguage = $('html').attr('lang')
  const dateFormat = DATE_FORMATS[currentLanguage] || DATE_FORMATS['en']
  $('.datepicker input').datepicker({ format: dateFormat, clearBtn: true })
})
// END: Addition
