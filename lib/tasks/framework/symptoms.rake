# Parses ICD-9 codes (specifically symptoms part) 
# and puts them into symptoms data model as names
namespace :framework do
  desc "Scrape data about symptoms"
  task symptoms: :environment do
    print "Parsing symptoms...\n"
    agent = Mechanize.new
    base_url = "http://www.icd9data.com/2013/Volume1/default.htm"
    parse_page_symptom(base_url, agent, 1, 2)
    print "DONE\n"
  end
end

# Recursively goes through the url and parses
# disease names and corresponding ICD-9 codes 
def parse_page_symptom(url, agent, depth, exclude = 0)
  return if depth > 4 # Maximum granularity we need for this project
  item_number = 0
  page = agent.get(url)
  if depth < 4
    items = page.search(".codeList li")
  else
    items = page.search(".threeDigitCodeListDescription")
  end
  items[0..(items.length - exclude - 1)].each do |li|
    if depth == 4
      name = li.text
      print "...Parsing #{name}..."
      symptom = Symptom.find_by_name(name.titleize)
      symptom ||= Symptom.create(name: name.titleize)
      print "DONE\n"
    else
      if (item_number == 15 && depth == 1) || (depth > 1)
        link = li.search("a").first["href"]
        parse_page_symptom(link, agent, depth + 1)
      end
    end
    item_number = item_number + 1
  end
end