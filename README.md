== Find-a-Doc

by Feridun Mert Celebi, Jake Albert

= What is Find-a-Doc?

Find-a-Doc is a platform for finding physicians that are at the vicinity of the address input by the patient/user. The search can be customized with the symptoms of the patients to get specialists or if the disorder is already diagnosed, with the ICD-9 code of the disorder. If the data is available on the hospital websites, the patient should be able to state when (date and time) he or she wants to meet with a physician for the web application to match the patient with an available physician. These features mean that we need to scrape physician data from hospitals around Connecticut (and if data is available, US in general) and scrape a limited set of symptoms (and ICD-9 codes) and associate them with specialties. Patients can create profiles on the web application to get a history of the searches and the physicians that they have already visited.

= How will the project be implemented, tested and demoed?

The backend of this project will be implemented using the Ruby on Rails framework, backed by a PostgreSQL database. The frontend will mainly be implemented using HTML, CSS and JavaScript (Angular.js or Node.js). We decided to use Ruby on Rails, because it is user-friendly and makes web scraping relatively easy. We will use RSpec testing, using Faker and FactoryGirl gems to test and validate the implementation of our application. GitHub will be used for version controlling and the final web application will be hosted on Heroku for a live demo.
