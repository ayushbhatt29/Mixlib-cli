require "mixlib/cli"
class Owncli
  include Mixlib::CLI

  option :help,
    description: "This will provide help",
    long: "--help",
    short: "-h"

   option :give_argument,
          description: "This gives an argument.",
          long: "--give_argument ARG",
          short: "-g",
          in:['a','b','c']


  deprecated_option :printsomething,
      #description: "This prints something",
      long: "--print ARG",
      short: "-p",
      replacement: :give_argument,
      value_mapper: Proc.new { |op|
        case op
        when "h"; "a"
        when "i"; "b"
        else
          "c"
        end
      }

end

o=Owncli.new()
o.parse_options
if o.config.key? :give_argument
puts "Argument given is  #{o.config[:give_argument]}"
elsif o.config.key? :printsomething
puts "printing something #{o.config[:printsomething]}"
elsif o.config.key? :help
puts "help is #{o.config[:help]}"
else
  puts "invalid option"
end
