json.array!(@photos) do |json, photo|
  json.name photo.file_file_name
  json.size photo.file_file_size
  json.url photo.file.url(:original)
  json.thumbnail_url photo.file.url(:thumb)
  json.delete_url album_photo_url(@album, photo)
  json.delete_type "DELETE"
end