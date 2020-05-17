import { Controller } from 'stimulus'
import { fetchJobRecruitment } from '@apis/job_recruitments'
import { fetchCompanyIdsBySupervisingOrganization } from '@apis/supervising_organizations'

const statusesAvailableToSetFailed = [ 'assigned', 'learning', 'no_learning', 'no_examined' ]
const FIRST_ELEMENT = 0

export default class extends Controller {
  static get targets () {
    return [
      // For applicant modifying
      'applicant_id',
      'applicant_firstname',
      'applicant_lastname',
      'applicant_fullname',
      // For job cruitment informations
      'jobRecruitment__btnDisenroll',
      'jobRecruitment__btnSetFailedExamination',
      'jobRecruitment__editable',
      'jobRrecuitment_id',
      'jobRrecuitment_status',
      'jobRrecuitment_organnizationName',
      'jobRrecuitment_companyName',
      'jobRrecuitment_enteringFormAt',
      'jobRrecuitment_expectedEmigrateAt',
      'jobRrecuitment_emigratedAt',
      'jobRrecuitment_immigratedAt',
      'jobRrecuitment_passedExaminationAt',
      // For searching
      'supervisingOrganization_id',
      'company_id'
    ]
  }

  nameChanged() {
    const lastName = this.applicant_lastnameTarget.value.trim()
    const firstName = this.applicant_firstnameTarget.value.trim()
    const fullname = `${lastName} ${firstName}`
    this.applicant_fullnameTarget.value = fullname.trim()
  }

  jobRecruitmentChanged() {
    if (!this.jobRrecuitment_idTarget.value) return

    fetchJobRecruitment(
      this.jobRrecuitment_idTarget.value,
      this.applicant_idTarget.value
    ).then(({status, data}) => {
      if (status) {
        this.jobRrecuitment_organnizationNameTarget.value = data.supervising_organization_name
        this.jobRrecuitment_passedExaminationAtTarget.value = data.passed_examination_at
        this.jobRrecuitment_expectedEmigrateAtTarget.value = data.expected_emigrate_at
        this.jobRrecuitment_enteringFormAtTarget.value = data.entering_form_at
        this.jobRrecuitment_companyNameTarget.value = data.company_name
        this.jobRrecuitment_immigratedAtTarget.value = data.immigrated_at
        this.jobRrecuitment_emigratedAtTarget.value = data.emigrated_at
        this.jobRrecuitment_statusTarget.value = data.status
        // Toggle btn
        if (this.hasJobRecruitment__btnDisenrollTarget) {
          this.jobRecruitment__btnDisenrollTarget.style.display = data.status ? '' : 'none'
        }

        // Toggle btnSetFailedJobRecruitment
        if (this.hasJobRecruitment__btnSetFailedExaminationTarget) {
          const btnSetFailedDisplay = statusesAvailableToSetFailed.includes(data.status) ? '': 'none'
          this.jobRecruitment__btnSetFailedExaminationTarget.style.display = btnSetFailedDisplay
        }
        this.jobRrecuitment_statusTarget.dispatchEvent(new Event('change'))
      }
    })
  }

  supervisingOrganizationChanged() {
    if (!this.supervisingOrganization_idTarget.value) {
      this.enableCompaniesSelectOptions()
      return
    }

    fetchCompanyIdsBySupervisingOrganization(
      this.supervisingOrganization_idTarget.value
    ).then(({data}) => {
      const options = this.company_idTarget.options
      for (let i=0; i < options.length; i++) {
        options[i].disabled = Boolean(options[i].value) && !data.ids.includes(parseInt(options[i].value))
      }

      // Re-set the blank option when the current selected option is disabled
      if (options[options.selectedIndex].disabled == true) {
        options[FIRST_ELEMENT].selected = true
      }

      $(this.company_idTarget).selectpicker('refresh')
    })
  }

  toggleJobCruitmentEditable() {
    this._toggleJobCruitmentTargets(this.jobRecruitment__editableTarget.value == "false")
    $(this.jobRrecuitment_idTarget).selectpicker('refresh')
    $(this.jobRrecuitment_statusTarget).selectpicker('refresh')
  }

  enableCompaniesSelectOptions() {
    const options = this.company_idTarget.options
    for (let i=0; i < options.length; i++) {
      options[i].disabled = false
    }
    $(this.company_idTarget).selectpicker('refresh')
  }

  // Private
  _toggleJobCruitmentTargets(status) {
    this.jobRrecuitment_passedExaminationAtTarget.disabled = status
    this.jobRecruitment__editableTarget.value = status
    this.jobRrecuitment_immigratedAtTarget.disabled = status
    this.jobRrecuitment_emigratedAtTarget.disabled = status
    this.jobRrecuitment_statusTarget.disabled = status

    if (this.jobRrecuitment_idTarget.dataset.assigned == 'false') {
      this.jobRrecuitment_idTarget.disabled = status
    }
  }
}
