# NestedFieldsRails

Manage multiple models in the same form. Inspired on [nested_form gem](https://github.com/ryanb/nested_form)

Tested with Rails 3.2.x and Ruby 1.9.3

## Installation

Add this line to your application's Gemfile:

    gem 'nested_fields_rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nested_fields_rails

And then add it to the Asset Pipeline in the application.js file:    

	//= require jquery_nested_fields

## Usage

### Model definition

	class Person
		has_many :phones
		attr_accessible :phones_attributes
		accepts_nested_attributes_for :phones, :allow_destroy => true
	end

### Form specification

	= form_for @person do |f|
	  ...
	  %strong Phones
	  = f.link_to_add_nested_fields 'Add', :phones
	  = f.nested_fields_for :phones do |phones_form|
	    = phones_form.link_to_remove_nested_fields 'Remove'
	    = phones_form.text_field :number	

### Partials support

Main form

	= form_for @person do |f|
	  ...
	  %strong Phones
	  = f.link_to_add_nested_fields 'Add', :phones
	  = f.nested_fields_for :phones

Partial for item

    = f.link_to_remove_nested_fields 'Remove'
    = f.text_field :number	

### Html wrappers

Table wrapper

	= form_for @person do |f|
	  ...
	  %table
	  	%thead
	  	  %tr
	  	    %td f.link_to_add_nested_fields 'Add', :phones
	  	    %td Phones
        = f.nested_fields_for :phones, nil, :wrapper => :table do |phones_form|
	      %td= phones_form.link_to_remove_nested_fields 'Remove'
	      %td= phones_form.text_field :number

Custom wrapper

	= form_for @person do |f|
	  ...
	  %strong Phones
	  = f.link_to_add_nested_fields 'Add', :phones
	  = f.nested_fields_for :phones, nil, :collection_wrapper => :ul, :element_wrapper => :li do |phones_form|
	    = phones_form.link_to_remove_nested_fields 'Remove'
	    = phones_form.text_field :number	

### Order support

	= form_for @person do |f|
	  ...
	  %strong Phones
	  = f.link_to_add_nested_fields 'Add', :phones
	  = f.nested_fields_for :phones do |phones_form|
	    = phones_form.link_to_remove_nested_fields 'Remove'
	    = phones_form.link_to_up_nested_fields 'Up'
	    = phones_form.link_to_down_nested_fields 'Down'
	    = phones_form.text_field :number
	    = phones_form.index_nested_fields :order

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
