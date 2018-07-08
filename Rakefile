require "rake/testtask"

task default: :test

#task :test do 
#    ruby "./test/minitest.rb"
#end

Rake::TestTask.new(:test) do |t|
    t.libs << "lib" << "test"
    ruby "./test/minitest.rb"
end