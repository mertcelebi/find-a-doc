# Parse Saint Mary's Hospital providers
namespace :framework do
  desc "Scrape data about Saint Mary's Hospital providers"
  task mary: :environment do
    print "...Parsing Saint Mary's Hospital providers\n"
    agent = Mechanize.new
    num_pages = 534
    (1..num_pages).each do |page|
      base_mary = "http://www.stmh.org/find-a-physician/provider-profile-advanced/?id=#{page.to_s}"
      process_page_mary(base_mary, agent, page)
    end
    print "...DONE\n"
  end
end

def process_page_mary(url, agent, page)
  hospital_name = "Saint Mary's Hospital".titleize
  page = agent.get(url)
  valid = page.search(".BreadCrumbs p strong").text
  if valid == "Provider profile advanced"
    name = page.search(".DrName").text.titleize
    spec = page.search(".facetfe82fb1667204106bf8dc2d306652d98 ul li").first
    spec = spec.text.titleize unless spec.nil?
    if spec.nil?
      spec = "General"
    end
    print "......Parsing #{name} #{spec}"
    hospital = Hospital.find_by_name(hospital_name)
    hid = hospital.id.to_s
    provider  = Provider.create(name: name, hospital_id: hid)
    pid = provider.id.to_s
    specialty = Specialty.create(name: spec, provider_id: pid)
    print "...DONE\n"
  end
end