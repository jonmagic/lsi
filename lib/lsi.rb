require "open3"
require "lsi/command"
require "lsi/version"

class Lsi
  def self.run(*args)
    new(*args).run
  end

  def initialize(command:, path:, list_command:)
    @command = Command.new(command: command)
    @path = path
    @list_command = list_command
  end

  attr_reader :command, :path, :list_command

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
    if command.custom?
      print "Run `#{command.command} #{item_human_name(item)}`? [y,n,q] (y): "
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
      command.call(item)
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
