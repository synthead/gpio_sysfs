# frozen_string_literal: true

require "gpio_sysfs/pin"
require "gpio_sysfs/version"

class GpioSysfs
  SYS_PATH = "/sys/class/gpio"
  EXPORT_PATH = File.join(SYS_PATH, "export")
end
