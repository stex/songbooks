json.data do
  json.array!(@songs) do |song|
    json.(song, :identifier, :title, :artist)
  end
end