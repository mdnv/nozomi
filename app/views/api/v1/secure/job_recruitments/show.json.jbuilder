# frozen_string_literal: true

json.status true
json.data do
  json.supervising_organization_name @job_recruitment.send("supervising_organization_#{I18n.locale}_name")
  json.company_name                  @job_recruitment.send("company_#{I18n.locale}_name")
  json.expected_emigrate_at          l(@job_recruitment.expected_emigrate_at, format: :date_slash, default: nil)
  json.entering_form_at              l(@job_recruitment.entering_form_at, format: :date_slash, default: nil)
  json.status                        @applied_job&.status || ''
  json.emigrated_at                  l(@applied_job&.emigrated_at, format: :date_slash, default: nil)
  json.immigrated_at                 l(@applied_job&.immigrated_at, format: :date_slash, default: nil)
  json.passed_examination_at         l(@applied_job&.passed_examination_at, format: :date_slash, default: nil)
end
