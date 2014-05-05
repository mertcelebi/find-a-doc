namespace :framework do  
  desc "Setup framework"
  task setup: [
    # "framework:icd9", # Parse ICD-9 codes
    # "framework:symptoms" # Parse symptoms
    # "framework:states" # Parse states
    # "framework:hospitals" # Parse CT hospitals
    "framework:providers" # Parse CT hospital provider
  ]
end