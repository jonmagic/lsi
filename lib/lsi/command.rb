require "open3"

class Lsi
  class Command
    def initialize(command:)
      @command = command
    end

    attr_reader :command

    def custom?
      !!command
    end

    def call(item)
      if custom?
        custom(item)
      else
        default(item)
      end
    end

    def custom(item)
      stdout, stderr, status = Open3.capture3("#{command} #{item}")

      if status.success?
        puts stdout
      else
        puts stderr
      end
    end

    def default(path)
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
