require 'toto'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

#
# Create and configure a toto instance
#
toto = Toto::Server.new do
  #
  # Add your settings here
  # set [:setting], [value]
  # 
  # set :author,    'buddhamagnet'                            # blog author
  # set :title,     the mikroblog                             # site title
  # set :root,      'index'                                   # page to load on /
  # set :markdown,  :smart                                    # use markdown + smart-mode
  set :disqus,    'buddhamagnet'                            # disqus id, or false
  set :summary,   :max => 200, :delim => /~/                # length of article summary and delimiter
  # set :ext,       'txt'                                     # file extension for articles
  # set :cache,      28800                                    # cache duration, in seconds

  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }

  set :to_html   do |path, page, ctx|                         # returns an html, from a path & context
    ERB.new(File.read("#{path}/#{page}.rhtml")).result(ctx)
  end

  set :error     do |code|                                    # The HTML for your error page
    "<font style='font-size:300%'>toto, we're not in Kansas anymore (#{code})</font>"
  end

end

run toto


