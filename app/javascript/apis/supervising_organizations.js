export const fetchCompanyIdsBySupervisingOrganization = async (id) => {
  const response = await fetch(`/api/v1/secure/supervising_organizations/${id}/available_company_ids`)
  return await response.json()
}
