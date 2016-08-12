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

  def items
    if list_command
      stdout, stderr, status = Open3.capture3(list_command)

      if status.success?
        stdout.split("\n")
      end
    else
      Dir["#{path || Dir.pwd}/*"]
    end
  end

  def ask_question(item)
    if command
      print "Run `#{command} #{item_human_name(item)}`? [y,n,q] (y): "
    else
      print "Get info for `#{item_human_name(item)}`? [y,n,q] (y): "
    end
  end

  def item_human_name(item)
    if list_command
      item
    else
      File.basename(item)
    end
  end

  def wait_for_and_process_input(item)
    case STDIN.gets.chomp
    when "y", ""
      apply.call(item)
    when "n"
      # noop
    when "q"
      exit
    else
      exit!
    end
  end

  def run
    items.each do |item|
      ask_question(item)
      wait_for_and_process_input(item)
    end
  end
end
