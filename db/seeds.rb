# BEGIN: Create departments
puts '→ Start: Create departments...'

departments_data = ['Phòng hành chính', 'Phòng tuyển dụng', 'Phòng nội vụ']
Department.create(departments_data.map { |name| {vi_name: name, ja_name: name} })

puts '✓ Done: Create departments'
# END: Create departments

# BEGIN: Create staffs
puts '→ Start: Create staffs...'

defined_staffs_data = [
  'administrator@example.com',
  'super_administrator@example.com',
  'manager@example.com',
  'standard@example.com'
].map do |email|
  name = email.split('@').first
  {
    username: name,
    email: email,
    password: 'password',
    password_confirmation: 'password',
    department_id: Department.ids.sample
  }
end
Staff.create(defined_staffs_data)

staffs_data = 40.times.map do |i|
  {
    username: "#{Faker::Name.name} #{i}",
    email: "#{i}#{Faker::Internet.email}",
    password: 'password',
    password_confirmation: 'password',
    role: Staff.roles.keys.sample,
    status: :active,
    address: Faker::Address.street_address,
    department_id: Department.ids.sample
  }
end
Staff.create(staffs_data)

puts '✓ Done: Create staffs'
# END: Create staffs

# BEGIN: Create occupations
puts '→ Start: Create occupations...'

occupations_data = 20.times.map do
  name = Faker::Job.field
  {
    vi_name: name,
    ja_name: name,
    availability: :available
  }
end
Occupation.create(occupations_data)

puts '✓ Done: Create occupations'
# END: Create occupations

# BEGIN: Create supervising organizations
puts '→ Start: Create supervising organizations...'
supervising_organizations_data = 20.times.map do |i|
  name = Faker::Name.name
  {
    username: Faker::Company.name,
    email: "#{i}#{Faker::Internet.email}",
    password: 'password',
    password_confirmation: 'password',
    status: :active,
    vi_name: "#{name} vi",
    ja_name: "#{name} ja",
    address: Faker::Address.city,
    tel: Faker::PhoneNumber.cell_phone,
    ceo_name: Faker::Name.name
  }
end
SupervisingOrganization.create supervising_organizations_data

puts '✓ Done: Create supervising organizations'
# END: Create supervising organizations

# BEGIN: Create company
puts '→ Start: Create company...'

companies_data = 20.times.map do |_i|
  name = Faker::Company.name
  {
    supervising_organization_id: SupervisingOrganization.ids.sample,
    vi_name: name,
    ja_name: name,
    ceo_name: Faker::Name.name,
    address: Faker::Address.street_address,
    tel: Faker::PhoneNumber.cell_phone
  }
end
Company.create(companies_data)

puts '✓ Done: Create company'
# END: Create company

# BEGIN: Create job recruitments
puts '→ Start: Create job recruitments...'

job_recruitments_data = 20.times.map do
  chosen_company = Company.find(Company.ids.sample)
  {
    supervising_organization_id: chosen_company.supervising_organization_id,
    company_id: chosen_company.id,
    occupation_id: Occupation.ids.sample,
    entering_form_at: Time.zone.now + 1.month,
    expected_emigrate_at: Time.zone.now + 2.month,
    assigning_ended_at: Time.zone.now + 2.month,
    examination_started_at: Time.zone.now + 3.month
  }
end
JobRecruitment.create job_recruitments_data

puts '✓ Done: Create job recruitments'
# END: Create job recruitments

# BEGIN: Create applicants
puts '→ Start: Create applicants...'

applicants_data = 20.times.map do
  {
    creator_id: Staff.ids.sample,
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    fullname: Faker::Name.name,
    gender: Applicant.genders.keys.sample,
    birthdate: Date.current - (15..20).to_a.sample.years,
    birthplace: I18n.t('regions').keys.sample,
    hometown: I18n.t('regions').keys.sample,
    vietnam_phone_number: Faker::PhoneNumber.cell_phone,
    japan_phone_number: Faker::PhoneNumber.cell_phone,
    japan_address: Faker::Address.street_address,
    personal_note: Faker::Lorem.paragraph_by_chars(number: 256)
  }
end
Applicant.create applicants_data

puts '✓ Done: Create applicants'
# END: Create applicants
