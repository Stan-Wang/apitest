require "apitest/engine"
require "slim-rails"
require "rails-adminlte"
require "vuejs-rails"
require "ansi-to-html"
require "font-awesome-rails"
require "ionicons-rails"
require 'eventmachine'
require 'eventmachine-tail'
require 'websocket-eventmachine-server'

module Apitest
  @api_dir
  @theme
  @default_types

  def self.api_dir(dir = nil)
    @api_dir = dir if dir
    @api_dir
  end

  def self.theme(theme = nil)
    @theme = theme if theme
    @theme
  end

  def self.default_types(default_types = [])
    @default_types ||= {}
    default_types.each do |type|
      @default_types[type] = []
    end
    @default_types
  end
  def self.start_server_log_listen
    Process.detach(
      fork do
        p 'Kill Apitest WebSocket Process ...'
        `lsof -i :9527 |awk '$1 == "ruby"  {print $2}' |xargs kill -9`
        begin
          filename = "#{Rails.root}/log/#{Rails.env}.log"

          EventMachine.run do
            WebSocket::EventMachine::Server.start(:host => "0.0.0.0", :port => 9527) do |ws|
              proc = Proc.new { |line|
                ws.send Ansi::To::Html.new(line.strip).to_html.strip
              }
              EventMachine::file_tail(filename, Reader, &proc)
            end
            p 'Start Apitest WebSocket Process !'
          end
        rescue Exception => e
          retry
        end
      end
    )
  end

  class Reader < EventMachine::FileTail
    def initialize(path, startpos=-1, &block)
      super(path, startpos)
      @buffer = BufferedTokenizer.new
      @block = block
    end

    def receive_data(data)
      @buffer.extract(data).each { |line| @block.call(line) }
    end
  end
end

module ActionDispatch::Routing
  class Mapper
    def apitest_for(path , &block)
      mount Apitest::Engine => path
      Apitest::api_dir        'api'
      Apitest::theme          'blue-light'
      # Apitest::default_types  [ '业务API' , '工具API' , '辅助API' ]
      block.call
    end
  end
end

