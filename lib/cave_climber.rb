class CaveClimber
  def treasure_path(map, positions, h_andre, h_kana)
    return nil if map.nil? || positions.nil? || h_andre.nil? || h_kana.nil?

    kana_pos = positions[:kana]
    andre_pos = positions[:andre]
    treasure_pos = positions[:tesouro]

    visited_kana = {}
    visited_andre = {}

    queue_kana = [[kana_pos, "Kana: #{kana_pos}"]]
    queue_andre = [[andre_pos, "André: #{andre_pos}"]]

    while !queue_kana.empty? || !queue_andre.empty?

      # KANA
      unless queue_kana.empty?
        current_pos_kana, path_kana = queue_kana.shift


        if current_pos_kana == treasure_pos || visited_andre[current_pos_kana] 
          if visited_andre[current_pos_kana] 
            return "Encontro: #{path_kana} | #{visited_andre[current_pos_kana]}"
          elsif h_andre != h_kana
            return path_kana
          end
          else
          nil
        end
        

        visited_kana[current_pos_kana] = path_kana

        neighbors = []
        neighbors << [current_pos_kana[0] - 1, current_pos_kana[1]]
        neighbors << [current_pos_kana[0] + 1, current_pos_kana[1]]
        neighbors << [current_pos_kana[0], current_pos_kana[1] - 1]
        neighbors << [current_pos_kana[0], current_pos_kana[1] + 1]

        neighbors = neighbors.select do |pos|
          pos[0].between?(0, map.length - 1) &&
            pos[1].between?(0, map[0].length - 1) &&
            !visited_kana[pos] &&
            (map[pos[0]][pos[1]] - map[current_pos_kana[0]][current_pos_kana[1]]).abs <= h_kana
        end

        neighbors.each do |pos|
          queue_kana << [pos, "#{path_kana} -> #{pos}"]
        end
      end

      # ANDRE
      unless queue_andre.empty?
        current_pos_andre, path_andre = queue_andre.shift

        if current_pos_andre == treasure_pos || visited_kana[current_pos_andre]
          if visited_kana[current_pos_andre]
            return "Encontro: #{visited_kana[current_pos_andre]} | #{path_andre}"
          else
            return path_andre
          end
        end

        visited_andre[current_pos_andre] = path_andre

        neighbors = []
        neighbors << [current_pos_andre[0] - 1, current_pos_andre[1]]
        neighbors << [current_pos_andre[0] + 1, current_pos_andre[1]]
        neighbors << [current_pos_andre[0], current_pos_andre[1] - 1]
        neighbors << [current_pos_andre[0], current_pos_andre[1] + 1]

        neighbors = neighbors.select do |pos|
          pos[0].between?(0, map.length - 1) &&
            pos[1].between?(0, map[0].length - 1) &&
            !visited_andre[pos] &&
            (map[pos[0]][pos[1]] - map[current_pos_andre[0]][current_pos_andre[1]]).abs <= h_andre
        end

        neighbors.each do |pos|
          queue_andre << [pos, "#{path_andre} -> #{pos}"]
        end
      end
    end
  end
end
