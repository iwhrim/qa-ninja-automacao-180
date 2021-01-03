module Helpers
  def get_fixture(item)
    YAML.load(File.read(Dir.pwd + "/spec/fixtures/#{item}.yml"), symbolize_names: true)
  end
  module_function :get_fixture

  def get_thumb(file_name)
    File.open(File.join(Dir.pwd, "spec/fixtures/images", file_name), "rb")
  end
  module_function :get_thumb
end
