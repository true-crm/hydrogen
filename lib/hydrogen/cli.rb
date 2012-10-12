module Hydrogen
  class CLI < Thor
    class << self
      def inherited(base)
        Component.loaded.each do |component|
          component.commands.each do |hash|
            command_class, command_name = hash[:class], hash[:name]
            base.register command_class, command_name, command_class.usage_banner, command_class.description_banner
          end
        end
      end
    end

    desc "generate NAME ARGS", "run the given generator"
    def generate(name, *args)
      Hydrogen::Generators.invoke name, args
    end
  end
end
