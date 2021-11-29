# frozen_string_literal: true

require "spec_helper"

describe GpioSysfs do
  subject(:gpio_sysfs) { described_class }

  it "uses the correct GPIO sysfs base path" do
    expect(gpio_sysfs::SYS_PATH).to eq("/sys/class/gpio")
  end

  it "uses the correct GPIO sysfs path for export" do
    expect(gpio_sysfs::EXPORT_PATH).to eq("/sys/class/gpio/export")
  end

  it "sets the correct version" do
    expect(gpio_sysfs::VERSION).to eq("0.1.0")
  end
end
