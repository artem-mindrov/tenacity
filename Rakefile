require 'rubygems'
require 'bundler'

Bundler::GemHelper.install_tasks

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'rake/testtask'
require 'rcov/rcovtask'
require 'rake/rdoctask'
require 'yard'

task :default => :test

Rake::TestTask.new(:test) do |test|
  ENV['TENACITY_TEST'] = 'true'
  test.libs << 'lib' << 'test' << 'test/fixtures'
  test.pattern = ENV['TEST'] || "test/**/*_test.rb"
  test.verbose = true
end

desc 'Run an abbreviated version of the test suite'
task :quick_test do
  ENV['QUICK'] = 'true'
  Rake::Task["test"].invoke
end

Rcov::RcovTask.new do |test|
  test.libs << 'test' << 'test/fixtures'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "tenacity #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('EXTEND*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/**/*.rb', '-', 'EXTEND.rdoc']
end

desc 'Delete rcov, rdoc, yard, and other generated files'
task :clobber => [:clobber_rcov, :clobber_rdoc, :clobber_yard]

desc 'Delete yard generated files'
task :clobber_yard do
  puts 'rm -rf doc .yardoc'
  FileUtils.rm_rf ['doc', '.yardoc']
end

