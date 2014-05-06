# Parse St. Vincent's Medical Center providers
namespace :framework do
  desc "Scrape data about St. Vincent's Medical Center providers"
  task vincent: :environment do
    print "...Parsing St. Vincent's Medical Center providers\n"
    agent = Mechanize.new
    num_pages = 65
    (1..num_pages).each do |page|
      base_vincent = "http://www.stvincents.org/find-a-doctor/Find-a-Doctor-Results?pageindex=#{page.to_s}"
      process_page_vincent(base_vincent, agent)
    end
    print "...DONE\n"
  end
end

def process_page_vincent(url, agent)
  hospital_name = "St. Vincent's Medical Center".titleize
  page = agent.get(url)
  rows = page.search(".profile-info")
  rows[0..(rows.length - 1)].each do |tr|
    name = tr.search("h5 a").first.text.split(" ", 2).first.squeeze(" ").strip.titleize
    last = tr.search("h5 a").first.text.split(" ", 2).last.squeeze(" ").strip.titleize
    name = name + " " + last
    spec = tr.search(".subtitle").text.squeeze(" ").strip.titleize
    print "......Parsing #{name} #{spec}"
    hospital = Hospital.find_by_name(hospital_name)
    hid = hospital.id.to_s
    provider  = Provider.create(name: name, hospital_id: hid)
    pid = provider.id.to_s
    specialty = Specialty.create(name: spec, provider_id: pid)
    print "...DONE\n"
  end
end