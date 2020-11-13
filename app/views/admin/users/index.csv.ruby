require 'csv'

CSV.generate do |csv|
  column_names = %w(id text laundry_id gender age_id rate_id)
  csv << column_names
  @comments.each do |comment|
    column_values = [
      comment.id,
      comment.text,
      comment.laundry_id,
      comment.gender,
      comment.age_id,
      comment.rate_id
    ]
    csv << column_values
  end
end