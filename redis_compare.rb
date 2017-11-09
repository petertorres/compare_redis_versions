require 'sinatra'
require 'sinatra/reloader'
require 'redis'

host = 'localhost'
set :bind, '0.0.0.0'

$redis = Redis.new(host: host)
$keys = $redis.keys('dev*')

get '/' do
  @title = "Compare Redis Versions"
  haml :index
end

__END__

@@ layout
!!! 5
%html
  %head
    %title Redis Versions
    %link{:rel=>"stylesheet",
          :href=>"https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css",
          :integrity=>"sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb",
          :crossorigin=>"anonymous"}
  %body{:class=>'container'}
    %br
    %h3= @title 
    = yield

@@ index
%p Versions by environment
%table{:class=>'table table-hover table-striped'}
  %tr
  - ['Key Name','Dev','Pilot','Production'].each do |td|
    %th= td
  - $keys.each do |k| 
    %tr
      %td= k.match('::').post_match
      - ['dev','pilot','production'].each do |env|
        %td= $redis.get("#{env}::#{k.match('::').post_match}")
