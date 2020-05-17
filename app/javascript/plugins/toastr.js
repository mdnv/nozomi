import toastr from 'toastr';
import 'toastr/toastr.scss'

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
