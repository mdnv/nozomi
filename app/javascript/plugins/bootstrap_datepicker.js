require('bootstrap-datepicker')
import 'bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css'
import { DATE_FORMATS } from '@configs/date'

$(document).on('turbolinks:load', () => {
  // Setting datepicker format
  const currentLanguage = $('html').attr('lang')
  const dateFormat = DATE_FORMATS[currentLanguage] || DATE_FORMATS['en']
  $('.datepicker input').datepicker({ format: dateFormat, autoclose: true, clearBtn: true })
})
