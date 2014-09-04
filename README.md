# PrimerApi

This is the counterpart for the Primer web application, it provides an ActiveRecord style interface to Primer.

## Installation

Add this line to your application's Gemfile:

```ruby
  gem 'primer_api'
```

And then execute:

```
  $ bundle
```

Or install it yourself as:

```
  $ gem install primer_api
```

Once you have it loaded you can run the rails generator to create the initializer file:

```
  $ rails g primer_api:initializer
```

## Configuration

PrimerApi takes several config directives:
```ruby
  PrimerApi.configure do |config|
    # You should only override this in development and staging, staging it will be https://primer-staging.musicglue.com
    config.host       = 'https://primer.musicglue.com'

    # This is required, primer_api will not function without it.
    config.api_key    = 'your_api_key_here'

    # This is required, primer_api will not function without it
    config.api_secret = 'such_sekrets_much_private_wow'
  end
```

Api keys can be obtained from the primer web application

## Usage

PrimerApi allows you to create, delete and update jobs stored on the primer web service.

### Creating

You can create two types of scheduled jobs, a one off job `PrimerApi::SingleJob.new`, or a recurring job `PrimerApi::RecurringJob.new`.
NB: You must call save in order for the job to get persisted to primer.

#### Recurring

With a scheduled job you'll need to create an [ice_cube schedule](https://github.com/seejohnrun/ice_cube), and pass it in as the schedule attribute. For more information on ice_cube schedules please see the [ice_cube repository](https://github.com/seejohnrun/ice_cube)

```ruby
  job = PrimerApi::RecurringJob.new(schedule: scheudle, message_topic: :your_emmited_topic, payload: {data: :sent_back_in_the_notification})
  if job.save
    puts job.id #This is the unique job ID provided by primer, store it!
  else
    puts job.errors
  end
```

#### Single

Single jobs take the same generic arguments as recurring jobs, `:message_topic, :payload`, however you pass in the date and time of the next occurrence directly.

```ruby
  job = PrimerApi::SingleJob.new(next_occurrence: 1.day.from_now, message_topic: :your_emmited_topic, payload: {data: :sent_back_in_the_notification})
  if job.save
    puts job.id #This is the unique job ID provided by primer, store it!
  else
    puts job.errors
  end
```

##### Unique Single Jobs

You can enforce uniqueness on a ```SingleJob``` by specifying a string `:unique_key` value. This will ensure that is a job will only ever be created once.

```ruby
job = PrimerApi::SingleJob.new(unique_key: 'my_unique_key', next_occurrence: 1.day.from_now, message_topic: :your_emmited_topic, payload: {})
```

### Updating

In order to update you'll need to have the job ID that was returned during the save operation. Updates work very similarly for both types of job, you just have to supply the changed parameters.

```ruby
  job = PrimerApi::SingleJob.find(job_id)
  job.next_occurrence = 3.days.from_now
  job.save
```

The job ID will remain the same.

### Deleting

Destroying a job is as simple as finding the job from the api, and calling destroy on it.

```ruby
  PrimerApi::SingleJob.find(job_id).destroy
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/primer_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
