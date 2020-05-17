import { Controller } from 'stimulus'

const BACK_TO_WORK = 'back'
const OTHER_TREATMENT = 'other'

export default class extends Controller {
  static get targets () {
    return [
      'treatmentDuringIntern_content',
      'planWorkingPlace',
      'planWorkingDepartment',
      'planWorkingOccupation'
    ]
  }

  internProcessChanged(e) {
    const textboxes = document.querySelectorAll('.js-experiences-internProcess_content')
    textboxes.forEach((field) => {
      field.parentNode.classList.add('d-none')
      field.disabled = true
    })
    const internProcessBlock = e.currentTarget.parentNode.parentNode
    const currentTexbox = internProcessBlock.querySelector('.js-experiences-internProcess_content')
    if (currentTexbox) {
      currentTexbox.parentNode.classList.remove('d-none')
      currentTexbox.value = currentTexbox.dataset.value || ''
      currentTexbox.disabled = false
    }
  }

  treatmentDuringInternChanged(e) {
    const type = e.currentTarget.dataset.type

    if (type == OTHER_TREATMENT) {
      this.treatmentDuringIntern_contentTarget.disabled = false
      this._setValueByDataValue(this.treatmentDuringIntern_contentTarget)
    }
    else {
      this.treatmentDuringIntern_contentTarget.disabled = true
      this.treatmentDuringIntern_contentTarget.value = ''
    }
  }

  planAfterInternChanged(e) {
    const type = e.currentTarget.dataset.type
    this._togglePlanAfterIntern(type != BACK_TO_WORK)
  }

  // Private

  _setValueByDataValue(target) {
    target.value = target.dataset.value || ''
  }

  _togglePlanAfterIntern(status) {
    this.planWorkingPlaceTarget.disabled = status
    this.planWorkingDepartmentTarget.disabled = status
    this.planWorkingOccupationTarget.disabled = status

    if (status) {
      this._setValueByDataValue(this.planWorkingPlaceTarget)
      this._setValueByDataValue(this.planWorkingDepartmentTarget)
      this._setValueByDataValue(this.planWorkingOccupationTarget)
    }
  }
}
