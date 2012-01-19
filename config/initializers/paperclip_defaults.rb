Paperclip::Attachment.default_options.update({
  :storage => :fog,
  :fog_credentials => {
    :aws_access_key_id => AWS_ACCESS_KEY_ID,
    :aws_secret_access_key => AWS_SECRET_ACCESS_KEY,
    :provider => 'AWS',
    :region => 'us-east-1',
  },
  :fog_public => true,
  :fog_directory => S3_NAMESPACE,
  :fog_host => 'https://'+S3_CLOUDFRONT_DOMAIN
})
