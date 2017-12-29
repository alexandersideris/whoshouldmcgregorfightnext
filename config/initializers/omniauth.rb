OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '1081679679872-jqvvcjeamkjrasfaqff6htooo0qomkul.apps.googleusercontent.com', 'A4RsAm7sQryOYW7Cvv5ivlpM', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
