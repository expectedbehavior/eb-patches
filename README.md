# Eb::Patches

A collection of useful monkey patches for your projects.

## Installation

Add this line to your application's Gemfile:

    gem 'eb-patches'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eb-patches

## Usage

In Rails, in your `config/application.rb` file, you selectively choose
which patches you want to be included.

Patches can be applied by using the following pattern:

    Eb.monkey_patch <class>, "<method>"
    # or
    Eb.monkey_patch <class>, :<method>

e.g.

    Eb.monkey_patch Float, "approx"
    # or
    Eb.monkey_patch Float, :approx

The patches are as follows:

1. Float
    * `approx` - check if about the same as another given number based on
float's epsilons - whee floats!

2. String
    * `methodize` - get a stripped, snake-cased, downcased version of the string
    * `down_under` - same as methodize
    * `filename_sanitize` - get a version of the string that is usable as a
filename on basically any OS made since Windows 2000

3. Date/Time
    * `before?` - is this time before another time?
    * `after?` - is this time after another time?

4. Net::SMTP <span style='color:red'>(pending)</span>
    * `force_tls` - force TLS to be used, even for smtp services that don't
advertise it. *Note*: this will also cause the initializer to be aliased so TLS
can be enabled.
    * `reset_tls` - call this to allow Net::SMTP to automatically determine if
TLS should be used. This will have no effect if force_tls hasn't been included
already since it doesn't have any meaning otherwise

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Meta

Maintained by Expected Behavior

Released under the MIT license. http://github.com/expected-behavior/eb-patches
