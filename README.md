# Danbooru::Api

## Usage

    api = Danbooru::API.new(site)
    api.get(:post, :index, tags: 'blue') or api.post(:index, tags: 'blue')

Or

    Danbooru::API.get(site) do |api|
      api.post(:index, tags: 'blue')
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
