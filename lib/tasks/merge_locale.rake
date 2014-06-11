# This is not a usable rake task.
# Just to save code in project to create such a task.

# Load the translations for both languages.
# The french file is complete while the english one is very incomplete.
fr = YAML.load_file(Rails.root.join('config', 'locales', 'data_sheets', 'fr.yml'))
en = YAML.load_file(Rails.root.join('config', 'locales', 'data_sheets', 'en.yml'))

# We will use this proc to deep merge the keys.
deep_merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &deep_merger) : v2 }

# Now all the french translations keys (even nested) are in the hash.
# When the key have en english translation, this one is used. Else the french one is used.
translations = fr['fr'].merge(en['en'], &deep_merger)


# Such a task should display a warning when an english can't be found
# in order to avoid having french translations in the english file.
