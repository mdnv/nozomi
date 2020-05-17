export const fetchJobRecruitment = async (id, applicantId) => {
  const response = await fetch(`/api/v1/secure/job_recruitments/${id}?applicant_id=${applicantId}`)
  return await response.json()
}
