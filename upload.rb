#!/usr/bin/env ruby

require 'optparse'
require './uploader'
require 'yaml'

def main
  options = {:delete => nil, :file => nil}

  parser = OptionParser.new do|opts|
    opts.banner = "Usage: years.rb [options]"
    opts.on('-d', '--delete', 'delete') do |delete|
      options[:delete] = delete;
    end

    opts.on('-f', '--file file', 'file') do |file|
      options[:file] = file;
    end

    opts.on('-h', '--help', 'displays the help message') do
      puts opts
      exit
    end
  end

  parser.parse!

  if !options[:file]
    print "Enter file path: "
    options[:file] = gets.chomp
  end

  # Parse the configuration file and export the api token and the upload URL.
  config_file = YAML::load_file('config.yaml')
  api_token = config_file['api_token']
  url = config_file['url']

  # Define the image path retrieved from the command line arguments.
  image_path = options[:file]

  uploader = Uploader.new api_token, url, image_path
  uploader.screenshot()

  if options[:delete]
    File.delete(options[:file])
  end
end

main()
