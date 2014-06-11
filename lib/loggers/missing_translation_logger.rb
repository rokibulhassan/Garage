class MissingTranslationLogger
  LOGFILE = Rails.application.config.missing_translations_log
  SEPARATOR = ': '

  def self.call unfound
    logger.warn "#{FastGettext.locale}: #{unfound}"
  end

  def self.remove key, locale
    lines = File.readlines(LOGFILE).select{|line| line.slice("#{locale}: #{key.key}").nil?}
    File.open(LOGFILE, "w+") { |file| file.puts lines }
  end

  def self.unfound_translations
    unfound_translations = []

    File.open(LOGFILE, "r") do |infile|
      while line = infile.gets
        unfound_translations << UnfoundTranslation.new(line.chomp.split(SEPARATOR))
      end
    end

    unfound_translations
  end

  private

  def self.logger
    return @logger if @logger
    require 'logger'
    @logger = Logger.new(LOGFILE, 2, 5*(1024**2))#max 2x 5mb logfile
  end
end