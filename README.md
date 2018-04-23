compare_redis_versions
======================

A single-page Sinatra script for comparing values in Redis.  


### Requirements
`$ gem install sinatra sinatra-contrib redis haml`

or run Bundler to install dependencies:
`$ bundle install`

### Setup
- Set server target in `yaml/config.yml`

- The script reads all values of a provided key, and looks for redis entries in the following formats:

  `{ENVIRONMENT}::{APPLICATION_NAME}::{APPLICATION_VERSION}`

### Running
~~The Sinatra app is self-contained in one file.~~ 
The Sinatra app keeps its configuration information in YAML under `yaml/config.yml`
It uses an inline template, written in Haml, to iterate through the keys and create the view.

`$ ruby ruby_compare.rb`

and navigate to http://localhost:4567/.  

