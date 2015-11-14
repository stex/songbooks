json.data do
  json.(@song, :title, :artist)

  json.sections @song.sections do |section|
    json.(section, :name)

    json.lines section.lines do |line|
      json.array! line do |component|
        case component
        when SongComponents::Literal
          json.component_type 'literal'
          json.content component.to_s
        when SongComponents::Chord
          json.component_type 'chord'
          json.name component.name
          json.transposed_by component.transposed_by.to_s
        else
          json.type 'unknown'
          json.content 'unknown component: '
        end
      end
    end
  end
end