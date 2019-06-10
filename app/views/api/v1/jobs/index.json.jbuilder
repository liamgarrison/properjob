json.array! @jobs do |job|
  json.extract! job, :id, :category, :description
end