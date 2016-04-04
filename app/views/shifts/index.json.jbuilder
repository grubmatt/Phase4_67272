json.array!(@shifts) do |shift|
  json.extract! shift, :id, :assignment_id, :date, :start_time, :end_time, :notes
  json.url shift_url(shift, format: :json)
end
