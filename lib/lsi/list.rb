class Lsi
  class List
    def initialize(path:, list_command:)
      @path = path
      @list_command = list_command
    end

    attr_reader :path, :list_command

    def items
      if list_command
        stdout, stderr, status = Open3.capture3(list_command)

        if status.success?
          stdout.split("\n")
        end
      else
        directory_listing
      end
    end

    def item_human_name(item)
      if list_command
        item
      else
        File.basename(item)
      end
    end

    def directory_listing
      Dir["#{path || Dir.pwd}/*"]
    end
  end
end
