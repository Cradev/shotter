#!/usr/bin/env ruby

require 'json'
require 'rest_client'

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
