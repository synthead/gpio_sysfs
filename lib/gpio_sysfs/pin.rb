# frozen_string_literal: true

class GpioSysfs
  class Pin
    attr_accessor :pin

    def initialize(pin)
      @pin = pin
    end

    def export
      return if exported?

      File.write(EXPORT_PATH, pin)
    end

    def exported?
      File.exist?(pin_path)
    end

    def direction
      export

      File.read(direction_path).chomp
    end

    def direction=(direction)
      export

      File.write(direction_path, direction)
    end

    def value
      export

      File.read(value_path).to_i.positive?
    end

    def value=(value)
      self.direction = "out"

      File.write(value_path, normalized_value(value))
    end

    private

    def pin_path
      @pin_path ||= File.join(SYS_PATH, "gpio#{pin}")
    end

    def direction_path
      @direction_path ||= File.join(pin_path, "direction")
    end

    def value_path
      @value_path ||= File.join(pin_path, "value")
    end

    def normalized_value(value)
      case value
      when true
        1
      when false
        0
      else
        value
      end
    end
  end
end
