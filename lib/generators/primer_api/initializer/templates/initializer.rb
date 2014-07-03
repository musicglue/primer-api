PrimerApi.configure do |config|

  # Define your access keys for the PrimerApi, if you don't have an access key, you will need to log
  # in to primer and create a new application

  # You should only override this in development and staging, staging it will be https://primer-staging.musicglue.com
  # config.host       = 'https://primer.musicglue.com'

  # This is required, primer_api will not function without it.
  # config.api_key    = 'your_api_key_here'

  # This is required, primer_api will not function without it
  # config.api_secret = 'such_sekrets_much_private_wow'

end
