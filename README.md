# Summary

gpio\_sysfs is a simple, cross-platform GPIO library for Ruby that interacts
with sysfs without any gem dependencies.  This allows this library to interact
with a variety of GPIO interfaces from various vendors with ease.

Unlike some similar libraries, gpio\_sysfs does not read and write to
`/dev/mem`, which requires the root user to be running the code.  The user only
needs to have write access to `/sys/class/gpio`.

# Usage

To read from a pin:

```ruby
require "gpio_sysfs"

pin = GpioSysfs::Pin.new(18)
pin.direction = "in"

pin.value  # Returns true or false.
```

To write to a pin:

```ruby
require "gpio_sysfs"

pin = GpioSysfs::Pin.new(18)

pin.value = true
```

# Testing

The test suite will run on any machine with:

```shell
bundle exec rspec
```
