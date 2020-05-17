import { Controller } from 'stimulus'

const FIRST_CHILD_POSITION = 0

export default class extends Controller {
  static get targets () {
    return [
      'passport',
      'passport_number',
      'passport_issuedAt',
      'goneToJapan',
      'goneToJapan_reason',
      'relativeInJapan',
      'relativeInJapan_fullname',
      'relativeInJapan_relationship'
    ]
  }

  passportStatusChanged(e) {
    const passportStatus = e.currentTarget.dataset.value
    this._togglePassport(passportStatus != 'has')
  }

  goneToJapanStatusChanged(e) {
    const goneToJapanStatus = e.currentTarget.dataset.value
    if (goneToJapanStatus != 'has') {
      this.goneToJapan_reasonTarget.disabled = true
      this.goneToJapan_reasonTarget.value = ''
    }
    else {
      this.goneToJapan_reasonTarget.disabled = false
      this.goneToJapan_reasonTarget.value = this.goneToJapan_reasonTarget.dataset.value || ''
    }
  }

  relativeInJapanStatusChanged(e) {
    const relativeInJapanStatus = e.currentTarget.dataset.value
    this._toggleRelative(relativeInJapanStatus != 'has')
  }

  addNewFamilyMember() {
    const template = document.getElementsByClassName('js-familyComposition--template')[FIRST_CHILD_POSITION]
    const clonedTemplate = template.cloneNode(true)
    clonedTemplate.classList.remove('d-none')
    document.getElementsByClassName('js-familyComposition-list')[FIRST_CHILD_POSITION].append(clonedTemplate)
  }

  addNewLearningPeriod() {
    const template = document.getElementsByClassName('js-learningHistories--template')[FIRST_CHILD_POSITION]
    const clonedTemplate = template.cloneNode(true)
    clonedTemplate.classList.remove('d-none')
    document.getElementsByClassName('js-learningHistories-list')[FIRST_CHILD_POSITION].append(clonedTemplate)
  }

  addNewWorkingPeriod() {
    const template = document.getElementsByClassName('js-workingHistories--template')[FIRST_CHILD_POSITION]
    const clonedTemplate = template.cloneNode(true)
    clonedTemplate.classList.remove('d-none')
    document.getElementsByClassName('js-workingHistories-list')[FIRST_CHILD_POSITION].append(clonedTemplate)
  }

  removeElement(e) {
    const confirmationContent = e.currentTarget.dataset.confirmation
    if (confirm(confirmationContent)) {
      e.currentTarget.closest('tr').remove()
    }
  }

  // Private
  _dataValue(target) {
    return target.dataset.value || ''
  }

  _togglePassport(status) {
    this.passport_numberTarget.disabled = status
    this.passport_issuedAtTarget.disabled = status
    if (status) {
      this.passport_issuedAtTarget.classList.remove('form-control--readonly')
      this.passport_numberTarget.value = ''
      this.passport_issuedAtTarget.value = ''
    }
    else {
      this.passport_issuedAtTarget.classList.add('form-control--readonly')
      this.passport_numberTarget.value = this._dataValue(this.passport_numberTarget)
      this.passport_issuedAtTarget.value = this._dataValue(this.passport_issuedAtTarget)
    }
  }

  _toggleRelative(status) {
    this.relativeInJapan_fullnameTarget.disabled = status
    this.relativeInJapan_relationshipTarget.disabled = status
    if (status) {
      this.relativeInJapan_fullnameTarget.value = ''
      this.relativeInJapan_relationshipTarget.value = ''
    }
    else {
      this.relativeInJapan_fullnameTarget.value = this._dataValue(this.relativeInJapan_fullnameTarget)
      this.relativeInJapan_relationshipTarget.value = this._dataValue(this.relativeInJapan_relationshipTarget)
    }
  }
}
