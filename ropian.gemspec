# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ropian}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Geoff Garside"]
  s.date = %q{2009-04-24}
  s.email = %q{geoff@geoffgarside.co.uk}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "lib/ropian.rb",
    "lib/ropian/control/apc.rb",
    "lib/ropian/control/generic.rb",
    "lib/ropian/control/raritan.rb",
    "lib/ropian/meter/raritan.rb",
    "test/ropian_test.rb",
    "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/geoffgarside/ropian}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{Suite of tools for working with network power units}
  s.test_files = [
    "test/ropian_test.rb",
    "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<snmp>, [">= 1.0.2"])
    else
      s.add_dependency(%q<snmp>, [">= 1.0.2"])
    end
  else
    s.add_dependency(%q<snmp>, [">= 1.0.2"])
  end
end
