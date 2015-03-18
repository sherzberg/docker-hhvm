require 'docker'
require 'net/http'


describe "integration tests" do

  before(:all) do
    @image = Docker::Image.build_from_dir('.')
    @id = @image.id
    @container_id = `docker run -v $(pwd)/spec/files/php:/code/public -p 80 -d #{@id}`.chomp
    @inspect = Docker::Container.get(@container_id)
    @host_port = @inspect.json["NetworkSettings"]["Ports"]["80/tcp"][0]["HostPort"]
    sleep 2
  end

  after(:all) do
    `docker kill #{@container_id}`
  end

  it "is running" do
    expect(@inspect.json["State"]["Running"]).to be_truthy
  end

  it "serves php correctly" do
    url = URI.parse("http://localhost:#{@host_port}")
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }

    expect(res.body).to eq("OK PHP")
  end

end
