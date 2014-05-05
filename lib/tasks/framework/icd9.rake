# Parses ICD-9 codes (except the symptoms) and put them into
# ICD-9 data model as [name, code] pairs
namespace :framework do
  desc "Scrape data about ICD-9 codes"
  task icd9: :environment do
    print "Parsing ICD-9 codes...\n"
    agent = Mechanize.new
    base_url = "http://www.icd9data.com/2013/Volume1/default.htm"
    parse_page_icd9(base_url, agent, 1, 2)
    print "DONE\n"
  end
end

# Recursively goes through the url and parses
# disease names and corresponding ICD-9 codes 
def parse_page_icd9(url, agent, depth, exclude = 0)
  return if depth > 3 # Maximum granularity we need for this project
  item_number = 0
  page = agent.get(url)
  items = page.search(".codeList li")
  items[0..(items.length - exclude - 1)].each do |li|
    if depth == 3 # Only need (XXX) granularity ICD-9 codes
      name = li.text.split(" ", 2).last
      code = li.text.split(" ", 2).first
      print "...Parsing #{name}: #{code}..."
      icd9 = Icd9.find_by_name_and_icd9_code(name.titleize, code)
      icd9 ||= Icd9.create(name: name.titleize, icd9_code: code)
      print "DONE\n"
    else
      if !(item_number == 15 && depth == 1)
        link = li.search("a").first["href"]
        parse_page_icd9(link, agent, depth + 1)
      end
    end
    item_number = item_number + 1
  end
end