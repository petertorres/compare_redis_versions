require 'sinatra'
require 'sinatra/reloader'
require 'redis'
require 'set'
require 'yaml'

config = YAML.load_file('yaml/config.yml')
redis_host = config['host']
set :bind, '0.0.0.0'

begin
  Redis.ping(redis_host)
rescue StandardError => e
  abort("ERROR: Timed out connecting to Redis on #{redis_host}")
end

$redis = Redis.new(redis_host)

$all_keys = $redis.keys('*')
$keys = []

$all_keys.each do |k|
  $keys << k.match('::').post_match
end

$keys = $keys.to_set

get '/' do
  @title = "Compare Redis Versions"
  haml :index
end

__END__

@@ layout
!!! 5
%html
  %head
    %title Compare Versions
    %link{:rel=>"stylesheet",
          :href=>"https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css",
          :integrity=>"sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB",
          :crossorigin=>"anonymous"}
  %body{:class=>'container-fluid'}
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
        %td= $redis.get("#{env}::#{k}")
