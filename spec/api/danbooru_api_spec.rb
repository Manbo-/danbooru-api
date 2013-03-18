require "spec_helper"

describe Danbooru::API do
  let(:site){ "http://danbooru.donmai.us/" }

  it do
    Danbooru::API::VERSION.should_not be_nil
  end

  it do
    Danbooru::API::DEFAULT_FORMAT.should == :json
  end

  it do
    ->{ Danbooru::API.new(site).post }.should raise_error(ArgumentError)
  end

  describe "posts" do
    subject{ @response }

    let(:command){ :index }
    let(:limit) { 5 }
    let(:tags){ 'blue' }

    context "json" do
      let(:params) do
        {:limit => limit, :tags => tags}
      end
     
      before do
        VCR.use_cassette("danbooru_json") do
          @response = Danbooru::API.new(site).post(command, params)
        end
      end

      it do
        should be_a_kind_of(Array)
      end

      its(:first) do
        should be_a_kind_of(Hash)
      end

      its(:size) do
        should == limit
      end
    end

    context "xml" do
      let(:params) do
        {:limit => limit, :format => :xml, :tags => tags}
      end

      before do
        VCR.use_cassette("danbooru_xml") do
          @response = Danbooru::API.new(site).post(command, params)
        end
      end

      it do
        should be_a_kind_of(REXML::Document)
      end
    end
  end
end

