namespace :gemfile do
  desc 'Atualiza o seu arquivo Gemfile com as gems mais recentes'

  task :update do
    require 'tempfile'
    require 'fileutils'
    require 'nokogiri'
    require 'net/http'

    GEMFILE_PATH = "#{Rails.root}/Gemfile"

    temp_file = Tempfile.new(GEMFILE_PATH)
    begin
      File.open(GEMFILE_PATH, 'r') do |file|
        file.each_line do |line|

          if is_gem?(line)
            gem_name = gem_name(line)
            gem_info = last_gem_version(gem_name)

            puts "  Atualizando a gem #{gem_name}:"
            puts "   - Versão: #{gem_info[:last_version]};"
            puts "   - Data da atualização: #{gem_info[:date]};"
            puts "   - Tamanho da atualização: #{gem_info[:size]};"
            puts ''

            temp_file.puts update_line(line, gem_info[:version])
          elsif is_ruby_version?(line)
            ruby_info = last_ruby_version()

            puts '  Atualizando o Ruby:'
            puts "   - Versão mais recente: #{ruby_info[:version]};"
            puts "   - Data da atualização: #{ruby_info[:date]};"
            puts ''
            temp_file.puts "ruby '#{ruby_info[:version]}'"
          else
            temp_file.puts line
          end
        end
      end

      temp_file.close
      FileUtils.mv(temp_file.path, GEMFILE_PATH)
    ensure
      temp_file.close
      temp_file.unlink
    end

    puts '====================================='
    puts ''
    puts ' -> O seu Gemfile foi atualizado! <- '
    puts '   Você já pode visualizar o arquivo '
    puts '   na raiz do seu projeto ./Gemfile  '
    puts ''
    puts "   Agora execute: 'bundle install'   "
    puts ''
    puts '====================================='
  end
end

def last_ruby_version
  uri = URI('https://www.ruby-lang.org/en/downloads/releases/')
  body = Net::HTTP.get(uri)
  document = Nokogiri::HTML(body)

  ruby_versions =  document.css('.release-list tr')

  for index in 2..ruby_versions.size do
    version = document.css(".release-list tr:nth-child(#{index}) td:nth-child(1)").first.text.split[1]
    date = document.css(".release-list tr:nth-child(#{index}) td:nth-child(2)").first.text

    # Para não selecionar as versões que possuem o - no nome
    # como por exemplo: 3.2.0-preview1 ou 3.0.0-rc1
    break unless version.match?('-')
  end

  {
    version: version,
    date: date
  }
end

def last_gem_version(gem_name)
  uri = URI("https://rubygems.org/gems/#{gem_name}")
  body = Net::HTTP.get(uri)
  document = Nokogiri::HTML(body)

  version_parsed = document.css('#gemfile_text').first[:value].split(',').drop(1).join(',').strip
  last_version = document.css('.versions ol li:first-child a').first.text
  date = document.css('.versions ol li:first-child small').first.text.gsub('- ', '')
  size = document.css('.versions ol li:first-child span').first.text

  {
    version: version_parsed,
    last_version: last_version,
    date: date,
    size: size
  }
end

def update_line(line, gem_version)
  splitted = line.split(',')

  newLine = "#{splitted[0].gsub(/\n/, '')}, #{gem_version}"

  if splitted.size > 2
    versions = splitted.drop(2).select { |value| value.match(/[require|platforms]/) }

    for value in versions do
      newLine << ',' + value
    end
  end

  newLine
end

def gem_name(line)
  line.gsub(/\s+/, '').split(',')[0].gsub('gem\'', '').gsub(/\'/, '')
end

def is_gem?(line)
  line.gsub(/\s+/, '').start_with?('gem')
end

def is_ruby_version?(line)
  line.start_with?('ruby \'')
end
