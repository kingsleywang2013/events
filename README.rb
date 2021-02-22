# Mad Events -- Ruby

## Setup

1. Install the [bundler gem](http://bundler.io/) by running:

    ```gem install bundler```

2. Install dependencies:

    ```bundle install```

And you're ready to go!

### Running the app:
```ruby main.rb```

### Running the tests:
```bundle exec rspec```

## Requirements:
- Clients can create an event
- An event can include any number of talks
- A talk must have 1 speaker
- A talk must have a start and end time
- Talk times cannot overlap; they must be in sequential order. For example; a client cannot add a talk from 10am to 10:30am when a talk from 9:30am to 10:30am already exists in the even

### Example:
- CREATE EVENT event_name
- CREATE SPEAKER speaker_name
- CREATE TALK event_name talk_name talk_start_time talk_end_time speaker_name
- PRINT TALKS event_name => output the talks for an event sorted by the start time
