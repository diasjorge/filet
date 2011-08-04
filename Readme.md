# Filet

Filet is a dsl for acceptance testing on top of Test::Unit.

## Why filet?

Filet is framework agnostic, it can be used with plain Ruby or it can integrate with Rails or any framework of your choice, you can use it with Capybara, Webrat or any other tools you like.
Filet has no dependencies.
Filet is Test:Unit but pretty!

## Installation

    gem install filet

## Usage

To use filet just include in your test_helper

```ruby
require 'filet'
include Filet
```

## Hooks

We provide several hooks for options processing.

1. Filet.feature_hook

This allows to process the options you pass for the feature

```ruby
Filet.feature_hook do |base, options|
  base.send(:include, Capybara)
end
```

2. Filet.context_hook

This allows to process the options you pass for the context

```ruby
Filet.context_hook do |base, options|
  base.send(:include, SomeModule) if options[:js]
end
```
3. Filet.base_klass

This allows you to define the base_klass of your tests. It tries to make a guess based on your environment and integrates with Rails 3 and Rails 2. The default is Test::Unit::TestCase.

```ruby
Filet.base_klass = ActiveSupport::TestCase
```

*NOTE*: This hook must be initialized before you include the Filet module

## Example

```ruby
feature 'Creating a post', %{
  As a user
  I want to create a post
  In order to show it to people
} do

  scenario 'Everything goes fine after a submit' do
    # test code
  end

  context 'Something goes wrong', :js => true do
    scenario 'my keyboard stopped working' do
      # test code
    end

    scenario 'I forgot to fill up the form' do
      # test code
    end
  end
end
```

## Compatibility

Filet supports and is tested against ruby 1.8.7, 1.9.2, jruby-1.6.2 and rubinius-1.2.4

[![Build Status](http://travis-ci.org/xing/filet.png)](http://travis-ci.org/xing/filet)

### Rails Integration

It tries to make a guess based on your environment and integrates with Rails 3 and Rails 2. We recommend that you place your tests inside the test/integration folder.

## Acknowledgements

We'd like to thank our employer XING AG for letting us work on this project as part of our innovation time and releasing it as open source.
We also want to thank Luismi Cavallé for steak which was our inspiration to do this and all the great people that have made Testing so easy.
