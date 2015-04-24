VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join("spec","vcr")
  c.hook_into :faraday
end

RSpec.configure do |c|
  c.around(:example, :vcr) do |example|
    options = { erb: true, record: :once }
    VCR.use_cassette(:eaal, options) { example.call }
  end
end
