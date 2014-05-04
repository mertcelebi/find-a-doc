namespace :framework do  
  desc "Setup framework"
  task setup: [
    "framework:icd9", # Parse ICD-9 codes
    "framework:symptoms" # Parse symptoms
  ]
end