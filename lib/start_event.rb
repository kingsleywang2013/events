require_relative 'events'

class StartEvent
  class << self
    INSTRUCTION = [
      "Welcome to Mad Events",
      "You can set up events with the following requirements",
      "Requirement:",
      "- Clients can create an event",
      "- An event can include any number of talks",
      "- A talk must have 1 speaker",
      "- A talk must have a start and end time",
      "- Talk times cannot overlap; they must be in sequential order. For example; a client cannot add a talk from 10am to 10:30am when a talk from 9:30am to 10:30am already exists in the event",
      "",
      "Please input your event as following format",
      "Example:",
      "CREATE EVENT new_event",
      "CREATE SPEAKER Sam",
      "CREATE TALK new_event 'hello world' 2:00pm 2:30pm Sam",
      "PRINT TALKS new_event",
      "'help' to read the instruction and 'quit' or 'exit' to exit."
    ]

    def run
      start_message

      run_event
    end

    private

    def start_message
      puts instruction
      print prompt
    end

    def prompt
      '>'
    end

    def instruction
      INSTRUCTION.join("\n")
    end

    def empty_input_message
      'Empty command, please input again'
    end

    def run_event
      while input = gets.chomp
        # Exit the loop when input is 'quit' or 'exit'
        break if input == 'quit' || input == 'exit'

        # Prompt some instruction if input is empty
        if input == ''
          puts empty_input_message
          print prompt
          next
        end

        # Prompt help instruction
        puts instruction if input == 'help'

        # Execute input command and check if the input is valid.
        # If the input is valid, the event will return
        # the output otherwise it will print out the error instruction
        begin
          output = Events.run(input)
        rescue StandardError => e
          puts e
          print prompt
          next
        end

        puts output if output
        print prompt
      end
    end
  end
end
