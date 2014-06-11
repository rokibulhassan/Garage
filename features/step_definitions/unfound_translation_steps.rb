And /^the following unfound translations exist:$/ do |table|
  untranslated = table.hashes.map do |hash|
    [hash['key'], hash['key']].join(MissingTranslationLogger::SEPARATOR)
  end
  File.open(MissingTranslationLogger::LOGFILE, "w") do |file|
    file << untranslated
  end
end