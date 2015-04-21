require_relative './test_helper'

Job = PrimerApi::Job

describe Job do
  before do
    @valid_topic = 'do-the-thing'
    @valid_headers = { version: 4 }
    @valid_body = { some_key: 'some value' }
    @valid_schedule = IceCube::Schedule.new.to_hash

    @job = Job.new(
      message_body: @valid_body,
      message_headers: @valid_headers,
      message_topic: @valid_topic,
      schedule: @valid_schedule)
  end

  it 'can be valid' do
    _(@job).must_be :valid?
  end

  it 'must have a topic' do
    @job.message_topic = ''

    _(@job).wont_be :valid?
  end

  it 'must have an ice cube schedule' do
    @job.schedule = nil

    _(@job).wont_be :valid?

    @job.schedule = { foo: :bar }

    _(@job).wont_be :valid?
  end

  it 'can have nil message headers' do
    @job.message_headers = nil

    _(@job).must_be :valid?
  end

  it 'can have an empty hash for message headers' do
    @job.message_headers = {}

    _(@job).must_be :valid?
  end

  it 'cannot have non-hash values for message headers' do
    @job.message_headers = 123

    _(@job).wont_be :valid?
  end

  it 'can have a nil message body' do
    @job.message_body = nil

    _(@job).must_be :valid?
  end

  it 'can have an empty hash for the message body' do
    @job.message_body = {}

    _(@job).must_be :valid?
  end

  it 'cannot have a non-hash value for message body' do
    @job.message_body = 123

    _(@job).wont_be :valid?
  end

  it 'transforms an ice cube schedule assignment into a hash' do
    job = Job.new message_topic: @valid_topic
    job.schedule = IceCube::Schedule.new
    job.validate
    _(job.schedule).must_be_instance_of ActiveSupport::HashWithIndifferentAccess

    job = Job.new message_topic: @valid_topic, schedule: IceCube::Schedule.new
    job.validate
    _(job.schedule).must_be_instance_of ActiveSupport::HashWithIndifferentAccess
  end
end
