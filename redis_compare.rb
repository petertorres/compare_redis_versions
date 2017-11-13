require 'sinatra'
require 'sinatra/reloader'
require 'redis'

redis_host = 'localhost'
set :bind, '0.0.0.0'

$redis = Redis.new(host: redis_host)
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
    %link{:rel=>"icon",
          :type=>"image/png",
          :sizes=>"32x32",
          :href=>"/favicon-32x32.png"}
    %link{:rel=>"icon",
          :type=>"image/png",
          :sizes=>"16x16",
          :href=>"/favicon-16x16.png"}
    %link{:rel=>"apple-touch-icon",
          :sizes=>"180x180",
          :href=>"/apple-touch-icon.png"}
    %link{:rel=>"manifest",
          :href=>"/manifest.json"}
    %meta{:name=>"theme-color",
          :content=>"#ffffff"}
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
%table{:class=>'table table-condensed table-hover table-striped table-bordered'}
  %tr
  - ['Key Name','Dev','Pilot','Production'].each do |td|
    %th= td
  - $keys.each do |k| 
    %tr
      %td= k.match('::').post_match
      - ['dev','pilot','production'].each do |env|
        %td= $redis.get("#{env}::#{k.match('::').post_match}")
