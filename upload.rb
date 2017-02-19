#!/usr/bin/env ruby

require 'json'
require 'optparse'
require 'rest_client'
require 'yaml'

class Uploader

  def initialize(api_token, url, image_path)
    # Initialise the instance variables required for the class's methods to run.
    @api_token = api_token
    @url = url
    @image_path = image_path
  end

  def pbcopy(input)
  # Copy the input to the clip board (macOS only).
    str = input.to_s
    IO.popen('pbcopy', 'w') { |f| f << str }
    str
  end

  def parse_json(json_response)
    # Parse the returned JSON code and return the public URL.
    parsed = JSON.parse(json_response)
    link = parsed["public_url"]
    return link
  end

  def upload_image()
    # Upload the image to the server.
    json_response = RestClient.post @url, :token => @api_token, :file => File.new(@image_path, 'rb')
    return json_response
  end

  def screenshot
    # Retrieve the public url and copy the link to the clip board.
    json_response = upload_image()
    pbcopy(parse_json(json_response))
  end
end


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
