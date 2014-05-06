namespace :framework do  
  desc "Setup framework"
  task setup: [
    "framework:icd9", # Parse ICD-9 codes
    "framework:symptoms", # Parse symptoms
    "framework:hospitals", # Parse CT hospitals
    "framework:states", # Parse states
    "framework:backus", # Parse CT providers
    "framework:hocc",
    "framework:ccmc",
    # "framework:ynhh",
    "framework:windham",
    "framework:jmh",
    "framework:chh",
    "framework:lmh",
    "framework:middlesex",
    "framework:nmh",
    "framework:milford",
    "framework:rockville",
    "framework:vincent",
    "framework:mary"
  ]
end