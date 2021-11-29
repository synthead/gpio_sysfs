# frozen_string_literal: true

require "spec_helper"

describe GpioSysfs::Pin do
  let(:pin) { 18 }
  let(:gpio_sysfs) { described_class.new(pin) }

  before(:each) do
    # Ensure that files are never read nor written to.
    allow(File).to receive(:read)
    allow(File).to receive(:write)
  end

  describe "#export" do
    subject(:export) { gpio_sysfs.export }

    context "when #exported? returns true" do
      before(:each) do
        allow(gpio_sysfs).to receive(:exported?).and_return(true)
      end

      it "does not call File.write" do
        expect(File).to_not receive(:write)

        export
      end
    end

    context "when #exported? returns false" do
      before(:each) do
        allow(gpio_sysfs).to receive(:exported?).and_return(false)
      end

      it "exports GPIO pin with File.write" do
        expect(File).to receive(:write).with("/sys/class/gpio/export", 18)

        export
      end
    end
  end

  describe "#exported?" do
    subject(:exported?) { gpio_sysfs.exported? }

    it "calls File.exist? on the correct path" do
      expect(File).to receive(:exist?).with("/sys/class/gpio/gpio18")

      exported?
    end
  end

  describe "#direction" do
    subject(:direction) { gpio_sysfs.direction }

    it "calls #export before reading direction" do
      expect(gpio_sysfs).to receive(:export).ordered
      expect(File).to receive(:read).ordered.and_return("out\n")

      direction
    end

    it "reads GPIO direction with File.read" do
      expect(File).to receive(:read).with("/sys/class/gpio/gpio18/direction").and_return("out\n")

      direction
    end

    it "returns the expected direction" do
      allow(File).to receive(:read).with("/sys/class/gpio/gpio18/direction").and_return("out\n")

      expect(gpio_sysfs.direction).to eq("out")
    end
  end

  describe "#direction=" do
    subject(:direction) { gpio_sysfs.direction = "out" }

    it "calls #export before reading direction" do
      expect(gpio_sysfs).to receive(:export).ordered
      expect(File).to receive(:write).ordered

      direction
    end

    it "writes GPIO direction with File.write" do
      expect(File).to receive(:write).with("/sys/class/gpio/gpio18/direction", "out")

      direction
    end
  end

  describe "#value" do
    before(:each) do
      allow(File).to receive(:read).with("/sys/class/gpio/gpio18/direction").and_return("out\n")
    end

    subject(:value) { gpio_sysfs.value }

    it "calls #export before reading value" do
      expect(gpio_sysfs).to receive(:export).ordered
      expect(File).to receive(:read).ordered.and_return("1\n")

      value
    end

    it "reads GPIO value with File.read" do
      expect(File).to receive(:read).with("/sys/class/gpio/gpio18/value").and_return("1\n")

      value
    end

    context 'when value is "1\n"' do
      before(:each) do
        allow(File).to receive(:read).with("/sys/class/gpio/gpio18/value").and_return("1\n")
      end

      it "returns true" do
        expect(value).to eq(true)
      end
    end

    context 'when value is "0\n"' do
      before(:each) do
        allow(File).to receive(:read).with("/sys/class/gpio/gpio18/value").and_return("0\n")
      end

      it "returns false" do
        expect(value).to eq(false)
      end
    end
  end

  describe "#value=" do
    before(:each) do
      allow(File).to receive(:read).with("/sys/class/gpio/gpio18/direction").and_return("out\n")
    end

    subject(:value) { gpio_sysfs.value = true }

    it "sets the direction to out before writing value" do
      expect(gpio_sysfs).to receive(:direction=).with("out").ordered
      expect(File).to receive(:write).ordered

      value
    end

    context "with a value of true" do
      subject(:value) { gpio_sysfs.value = true }

      it "writes GPIO value of 1" do
        expect(File).to receive(:write).with("/sys/class/gpio/gpio18/value", 1)

        value
      end
    end

    context "with a value of false" do
      subject(:value) { gpio_sysfs.value = false }

      it "writes GPIO value of 0" do
        expect(File).to receive(:write).with("/sys/class/gpio/gpio18/value", 0)

        value
      end
    end

    context "with a value of 1" do
      subject(:value) { gpio_sysfs.value = 1 }

      it "writes GPIO value of 1" do
        expect(File).to receive(:write).with("/sys/class/gpio/gpio18/value", 1)

        value
      end
    end

    context "with a value of 0" do
      subject(:value) { gpio_sysfs.value = 0 }

      it "writes GPIO value of 0" do
        expect(File).to receive(:write).with("/sys/class/gpio/gpio18/value", 0)

        value
      end
    end
  end
end
