module UriComparison
  class Uri
    attr_reader :scheme, :host, :port, :resource

    def initialize(uri)
      uri = set_scheme! uri
      uri = set_host_and_port! uri
      set_resource! uri
    end

    def ==(other)
      scheme == other.scheme &&
      host == other.host &&
      port == other.port &&
      resource == other.resource
    end

    private
      def set_scheme!(uri)
        @scheme, rest = uri.split(/:\/\//)
        @scheme.downcase!
        rest
      end

      def set_host_and_port!(uri)
        @host = uri[/^[^\/]+/]
        @host.downcase!
        if (colon = @host =~ /:/)
          @port = @host[(colon+1)..-1].to_i
          @host = @host[0...colon]
        else
          @port = 80
        end
        uri[(uri =~ /\//)..-1] rescue ''
      end

      def set_resource!(uri)
        @resource = uri
        @resource.gsub!(/(?<!%)(?<!%\h)[^,\/?:@&=+\-$#%]/) { |s| '%' + s.ord.to_s(16) }
        @resource.upcase!
      end
  end

  def self.same_uri?(line)
    uri1, uri2 = line.split(/;/)
    Uri.new(uri1) == Uri.new(uri2)
  end

  def self.run(filename = ARGV[0])
    File.open(filename) do |file|
      file.each_line do |line|
        line.strip!
        next if line.empty?

        puts same_uri?(line) ? "True" : "False"
      end
    end
  end
end

UriComparison.run if __FILE__ == $0