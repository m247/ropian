# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name = "ropian"
  s.version = "0.1.2.pre"
  s.authors = ["Geoff Garside"]
  s.email = ["geoff@geoffgarside.co.uk"]
  s.homepage = "http://github.com/geoffgarside/ropian"
  s.summary = "Suite of tools for working with network power distribution units"
  s.description = "Provides metering and control of network power distribution units"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency "snmp", ">= 1.0.2"

  s.files = `git ls-files`.split("\n") - %w(doc/apc.mib doc/raritan.mib)
  s.require_paths = ["lib"]

  s.add_development_dependency "yard"
end
