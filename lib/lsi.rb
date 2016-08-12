require "open3"
require "lsi/command"
require "lsi/list"
require "lsi/version"

class Lsi
  def self.start(*args)
    new(*args).start
  end

  def start
    list.items.each do |item|
      ask_question(item)
      wait_for_and_process_input(item)
    end
  end

  def initialize(command:, path:, list_command:)
    @command = Command.new(command: command)
    @list = List.new(path: path, list_command: list_command)
  end

  attr_reader :command, :list

  def ask_question(item)
    if command.custom?
      print "Run `#{command.command} #{list.item_human_name(item)}`? [y,n,q] (y): "
    else
      print "Get info for `#{list.item_human_name(item)}`? [y,n,q] (y): "
    end
  end

  def wait_for_and_process_input(item)
    case STDIN.gets.chomp
    when "y", ""
      command.run(item)
    when "n"
      # noop
    when "q"
      exit
    else
      exit!
    end
  end
end
