#----------------------------------------------------------------
#                        Fonts
#----------------------------------------------------------------

pdf.font_families.update('DejaVuSansMono' => {
    :normal => Songbooks.font_file('DejaVuSansMono'),
    :italic => Songbooks.font_file('DejaVuSansMono-Oblique'),
    :bold => Songbooks.font_file('DejaVuSansMono-Bold'),
    :bold_italic => Songbooks.font_file('DejaVuSansMono-BoldOblique')
})

@toc = {}

pdf.start_new_page

@songs.each do |song|
  pdf.text song.title, :size => 18
  pdf.text song.artist

  @toc["#{song.title} - #{song.artist}"] = pdf.page_count

  song_y = pdf.cursor
  text_x = pdf.width_of(song.longest_section_caption) + 10

  pdf.font 'DejaVuSansMono', :size => 9 do

    song.sections.each do |section|
      pdf.draw_text section.name, :at => [text_x - pdf.width_of(section.name) - 10, song_y], :style => :bold

      section.lines.each do |line|
        line_x = text_x

        line.each do |component|
          case component
            when SongComponents::Literal
              pdf.draw_text component.to_s, :at => [line_x, song_y]
            when SongComponents::Chord
              pdf.fill_color '8B0000'
              pdf.draw_text component.to_s, :at => [line_x, song_y]
              pdf.fill_color '000000'
          end

          line_x += pdf.width_of(component.to_s)
        end
        song_y -= 12

        if song_y < 10
          pdf.start_new_page
          song_y = 700
        end
      end
    end
  end

  pdf.start_new_page unless song == @songs.last
end

pdf.go_to_page 1

#----------------------------------------------------------------
#                     Table of Contents
#----------------------------------------------------------------

pdf.font 'DejaVuSansMono', :size => 11 do
  @toc.keys.sort.each do |k|
    min_width = pdf.width_of("#{k}    #{@toc[k]}")
    dots = ''
    dots << '.' while pdf.width_of(dots) < (530 - min_width)

    pdf.text "#{k}  #{dots}  #{@toc[k]}"
  end
end

#----------------------------------------------------------------
#                        Page Numbers
#----------------------------------------------------------------

pdf.number_pages '<page>',
                 :page_filter => lambda{ |pg| pg != 1 },
                 :at => [pdf.bounds.right - 50, 0]