json.extract! cat_rental_request, :id, :cat_id, :start_date, :end_date, :status, :created_at, :updated_at
json.url cat_rental_request_url(cat_rental_request, format: :json)
