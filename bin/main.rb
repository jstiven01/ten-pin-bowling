# frozen_string_literal: true

File.open('results.txt', 'r') do |f|
  f.each_line do |line|
    puts line
  end
end
