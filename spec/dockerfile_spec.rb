require 'docker'

describe "Dockerfile semantics" do

  before(:all) do
    @image = Docker::Image.build_from_dir('.')
  end
 
  it "build image exists" do
    expect(@image).not_to be_nil
  end
 
  it "has CMD" do
    expect(@image.json["Config"]["Cmd"]).to eq(["/sbin/my_init"])
  end

  it "exposes the default port" do
    expect(@image.json["Config"]["ExposedPorts"].has_key?("80/tcp")).to be_truthy
  end
 
  it "has proper workdir" do
    expect(@image.json["Config"]["WorkingDir"]).to eq("/code/public")
  end
 
end
