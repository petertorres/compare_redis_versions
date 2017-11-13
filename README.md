compare_redis_versions
======================

A single-page Sinatra script for comparing values in Redis.  


### Requirements
`$ gem install sinatra sinatra-contrib redis haml`

### Setup
The script reads all values of a given key, and looks for redis entries in the following formats:

`{ENVIRONMENT}::{APPLICATION_NAME}::{APPLICATION_VERSION}`

### Running
The Sinatra app is self-contained in one file.  
It uses an inline template, written in Haml, to iterate through the keys and create the view.

`$ ruby ruby_compare.rb`

and navigate to http://localhost:4567/.  

### TODO
- [ ] Remove dependency on an environment key for de-dupe
- [x] Increase left and right margin formatting
