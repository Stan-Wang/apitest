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
end



