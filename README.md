compare_redis_versions
======================

A single-page Sinatra script for comparing values in Redis.  


### Requirements
`$ gem install sinatra sinatra-contrib redis haml`

### Setup
The script reads all values of a given key, and looks for redis entries in the following formats:

- `{ENVIRONMENT}::{APPLICATION_NAME}::{APPLICATION_VERSION}`

### Running
The script is self-contained in one file.  It uses an inline template to iterate through the keys.  

`$ ruby ruby_compare.rb`

### TODO
- [ ] Remove dependency on an environment key for de-dupe.
- [ ] Fix left margin formatting.
