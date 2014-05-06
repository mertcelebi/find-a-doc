# Parse The Lawrence + Memorial Hospital providers
namespace :framework do
  desc "Scrape data about Lawrence + Memorial Hospital providers"
  task lmh: :environment do
    print "...Parsing Lawrence + Memorial Hospital providers\n"
    agent = Mechanize.new
    num_pages = 2500
    (1..num_pages).each do |page|
      base_lmh = "http://www.lmhospital.org/find-a-physician/physician-detail.aspx?recid=#{page.to_s}"
      process_page_lmh(base_lmh, agent)
    end
    print "...DONE\n"
  end
end

def process_page_lmh(url, agent)
  hospital_name = "Lawrence + Memorial Hospital".titleize
  page = agent.get(url)
  rows = page.search(".Main")
  rows[0..(rows.length - 1)].each do |tr|
    name = tr.search(".block h1").text.titleize
    if name != " , "
      tag = tr.search(".DrDetail h4")
      speci = tr.search(".DrDetail p")
      i = 0
      tag[0..(tag.length - 1)].each do |sp|
        tag = sp.text
        if tag == "Specialties:"
          spec = speci[i - 1].text.titleize
          print "......Parsing #{name} #{spec}"
          hospital = Hospital.find_by_name(hospital_name)
          hid = hospital.id.to_s
          provider  = Provider.create(name: name, hospital_id: hid)
          pid = provider.id.to_s
          specialty = Specialty.create(name: spec, provider_id: pid)
          print "...DONE\n"
        end
        i = i + 1
      end
    end  
  end
end