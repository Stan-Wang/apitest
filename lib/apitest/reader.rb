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
end
  