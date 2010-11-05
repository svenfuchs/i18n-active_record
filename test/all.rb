dir = File.dirname(__FILE__)
$:.unshift(dir)

Dir["#{dir}/**/*_test.rb"].sort.each do |file|
  require file.sub(/^#{dir}\/(.*)\.rb$/, '\1')
end

