require "rspec"
require "webmock"
require "vcr"

require "./lib/danbooru-api"

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock
end

