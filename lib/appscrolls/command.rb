require 'appscrolls'
require 'thor'

module AppScrollsScrolls
  class Command < Thor
    include Thor::Actions
    desc "new APP_NAME", "create a new Rails app"
    method_option :scrolls, :type => :array, :aliases => "-s", :desc => "List scrolls, e.g. -s resque rails_basics jquery"
    method_option :template, :type => :boolean, :aliases => "-t", :desc => "Only display template that would be used"
    def new(name)
      if options[:scrolls]
        run_template(name, options[:scrolls], options[:template])
      else
        @scrolls = []

        while scroll = ask("#{print_scrolls}#{bold}Which scroll would you like to add? #{clear}#{yellow}(blank to finish)#{clear}")
          if scroll == ''
            run_template(name, @scrolls)
            break
          elsif AppScrollsScrolls::Scrolls.list.include?(scroll)
            @scrolls << scroll
            puts
            puts "> #{green}Added '#{scroll}' to template.#{clear}"
          else
            puts
            puts "> #{red}Invalid scroll, please try again.#{clear}"
          end
        end
      end
    end

    desc "list [CATEGORY]", "list available scrolls (optionally by category)"
    def list(category = nil)
      if category
        scrolls = AppScrollsScrolls::Scrolls.for(category).map{|r| AppScrollsScrolls::Scroll.from_mongo(r) }
      else
        scrolls = AppScrollsScrolls::Scrolls.list_classes
      end

      scrolls.each do |scroll|
        puts scroll.key.ljust(15) + "# #{scroll.description}"
      end
    end

    no_tasks do
      def cyan; "\033[36m" end
      def clear; "\033[0m" end
      def bold; "\033[1m" end
      def red; "\033[31m" end
      def green; "\033[32m" end
      def yellow; "\033[33m" end

      def print_scrolls
        puts
        puts
        puts
        if @scrolls && @scrolls.any?
          puts "#{green}#{bold}Your Scrolls:#{clear} " + @scrolls.join(", ")
          puts
        end
        puts "#{bold}#{cyan}Available Scrolls:#{clear} " + AppScrollsScrolls::Scrolls.list.join(', ')
        puts
      end

      def run_template(name, scrolls, display_only = false)
        puts
        puts
        puts "#{bold}Generating and Running Template...#{clear}"
        puts
        file = Tempfile.new('template')        
        template = AppScrollsScrolls::Template.new(scrolls)

        puts "Using the following scrolls:"
        template.resolve_scrolls.map do |scroll|
          color = scrolls.include?(scroll.new.key) ? green : yellow # yellow - automatic dependency
          puts "  #{color}* #{scroll.new.name}#{clear}"
        end
        puts

        file.write template.compile
        file.close
        if display_only
          puts "Template stored to #{file.path}"
          puts File.read(file.path)
        else
          system "rails new #{name} -m #{file.path} #{template.args.join(' ')}"
        end
      ensure
        file.unlink
      end
    end
  end
end
