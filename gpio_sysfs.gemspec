# frozen_string_literal: true

require_relative "lib/gpio_sysfs/version"

Gem::Specification.new do |spec|
  spec.name        = "gpio_sysfs"
  spec.version     = GpioSysfs::VERSION
  spec.summary     = "Portable sysfs-driven GPIO library for Ruby"
  spec.authors     = ["Maxwell Pray"]
  spec.email       = "synthead@gmail.com"
  spec.files       = Dir["lib/**/*"]
  spec.homepage    = "https://github.com/synthead/gpio_sysfs"
  spec.license     = "MIT"

  spec.add_development_dependency "rspec", "~> 3.10.0"
end
