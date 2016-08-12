require "lsi/version"

class Lsi
  def self.run(*args)
    new(*args).run
  end

  def initialize(command:, path:, list_command:)
    @command = command
    @path = path
    @list_command = list_command
  end

  attr_reader :command, :path, :list_command

  def apply
    if command
      lambda do |path|
        stdout, stderr, status = Open3.capture3("#{command} #{path}")

        if status.success?
          puts stdout
        else
          puts stderr
        end
      end
    else
      lambda do |path|
        filename = File.basename(path)
        stat = File.stat(path)

        if stat.directory?
          puts "#{filename} is a directory with permissions #{sprintf("%o", stat.mode)}"
        else
          puts "#{filename} is a #{stat.size} byte file with permissions #{sprintf("%o", stat.mode)}"
        end
      end
    end
  end

  def list
    if list_command
      stdout, stderr, status = Open3.capture3(list_command)

      if status.success?
        stdout.split("\n")
      end
    else
      Dir["#{path || Dir.pwd}/*"]
    end
  end

  def run
    list.each do |item|
      filename = File.basename(item)

      if command
        print "Run `#{command} #{filename}`? [y,n,q] (y): "
      else
        print "Get info for `#{filename}`? [y,n,q] (y): "
      end

      case STDIN.gets.chomp
      when "y", ""
        apply.call(item)
      when "n"
        next
      when "q"
        exit
      else
        exit!
      end
    end
  end
end
