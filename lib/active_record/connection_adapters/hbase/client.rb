require 'httparty'
require 'json'
require 'msgpack'

module HbaseRestIface
  class Client
    include HTTParty

    def initialize(ops)
      ops ||= {}
      ops[:host] ||= 'localhost'
      ops[:port] ||= '9191'
      
      @ops = ops
      @query_options = {}
      @info = { :version => '1' }
      
      connect
    end
    
    def [](key)
      @ops[key]
    end
    def []=(key,val)
      @ops[key]=val
    end
    
    def query(sql)
      File.open('/tmp/thing.txt', 'a') { |file| file.write("\n!!query\n#{sql}") }
      query_object = HipsterSqlToHbase.parse_hash(sql)
      File.open('/tmp/thing.txt', 'a') { |file| file.write("\n#{query_object.inspect}") }
      begin
        result = secure_request("/exec", { body: {query: MessagePack.pack(query_object)} })
        Hbase::Result.new(result) unless result.nil?
      rescue Exception => e
        #File.open('/tmp/thing.txt', 'a') { |file| file.write("\n\n!!!error\n#{e.message}") }
        nil
      end
    end
    
    def connect
      self.class.base_uri "#{@ops[:host]}:#{@ops[:port]}"
      #File.open('/tmp/thing.txt', 'a') { |file| file.write("\n\n!!!connect\n#{@ops[:host]}:#{@ops[:port]}") }
      ping
    end
    
    def ping
      simple_request("/ping")[0]
    end
    
    def simple_request(route, query=nil)
      if query.nil?
        response = self.class.get(route)
      else
        response = self.class.get(route, query)
      end
      
      if response.code.to_s =~ /2\d\d/
        MessagePack.unpack(response.body)
      else
        error = Nokogiri::HTML(response.body)
        #binding.pry
        raise error.css("title")[0].text
      end
    end
    
    def secure_request(route, body=nil)
      if body.nil?
        response = self.class.post(route)
      else
        response = self.class.post(route, body)
      end
      
      if response.code.to_s =~ /2\d\d/
        MessagePack.unpack(response.body)
      else
        error = Nokogiri::HTML(response.body)
        #binding.pry
        raise error.css("title")[0].text
      end
    end
    
    def info
      @info
    end
    
    def query_options
      @query_options
    end
    
    def close
      nil
    end
    
    def abandon_results!
      nil
    end
    
    def escape(string)
      string
    end
    
    def info
      nil
    end
    
    def server_info
      nil
    end
    
    def socket
      nil
    end
    
    def async_result
      nil
    end
    
    def last_id
      nil
    end
    
    def affected_rows
      nil
    end
    
    def thread_id
      nil
    end
    
    def select_db
      nil
    end
    
    def more_results?
      nil
    end
    
    def next_result
      nil
    end
    
    def store_result
      nil
    end
    
    def reconnect=
      nil
    end
    
    def warning_count
      nil
    end
    
    def query_info_string
      nil
    end
    
    def encoding
      nil
    end
    
    def connect_timeout=(o)
      nil
    end
    
    def read_timeout=(o)
      nil
    end
    
    def write_timeout=(o)
      nil
    end
    
    def local_infile=(o)
      nil
    end
    
    def charset_name=(o)
      nil
    end
    
    def secure_auth=(o)
      nil
    end
    
    def default_file=(o)
      nil
    end
    
    def default_group=(o)
      nil
    end
    
    def init_command=(o)
      nil
    end
    
    def ssl_set
      nil
    end
    
    def initialize_ext
      nil
    end
  end
end