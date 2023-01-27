require 'google/cloud/firestore'

Google::Cloud::Firestore.configure do |config|
  config.project_id  = Rails.application.credentials.dig(:google, :project_id)
  config.credentials = Rails.application.credentials.dig(:google, :firebase_path)
end
