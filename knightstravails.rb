require 'set'

class TreeNode
  attr_accessor :value, :parent, :children

  def initialize(value, parent= nil, children = [] )
    @value = value
    @parent = parent
    @children = children
  end

  def add_child(child)
    self.children << child
    child.parent = self
  end

  def bfs(find_value)
    nodes_to_search = [self]
    until nodes_to_search.empty?
      current_node = nodes_to_search.shift
      if current_node.value == find_value
        return current_node
      else
        nodes_to_search += current_node.children
      end
    end
  end

  def path
    if self.parent.nil?
      return [self.value]
    end
    self.parent.path + [self.value]
  end


end

class KnightPathFinder

  def initialize(start_pos)
    @start_pos = TreeNode.new(start_pos)
    self.build_move_tree
  end

  def build_move_tree
    visited_positions = Set.new
    queue = [@start_pos]

    until queue.empty?
      current = queue.shift
      visited_positions.add(current)
      new_positions = KnightPathFinder.new_move_positions(current.value)

      new_positions.each do |new_pos|
        unless visited_positions.include?(new_pos)
          new_pos_node = TreeNode.new(new_pos)
          visited_positions << new_pos_node.value
          queue << new_pos_node
          current.add_child(new_pos_node)
        end
      end
    end

    nil
  end

  def find_path(target_pos)
    target_node = @start_pos.bfs(target_pos)
    target_node.path
  end

  def self.new_move_positions(pos)
    changes = [
      [2, 1],
      [2, -1],
      [1, 2],
      [-1, 2],
      [-2, -1],
      [1, -2],
      [-1, -2],
      [-2, 1]
    ]

    x, y = pos
    changes.map { |dx, dy| [x + dx, y + dy] }
           .select { |move| KnightPathFinder.valid_move?(move) }
  end

  def self.valid_move?(pos)
    pos.all? {|coord| (coord <= 7 && coord >= 0) }
  end

end


if __FILE__ == $PROGRAM_NAME
  knight = KnightPathFinder.new([0, 0])
  p knight.find_path([7, 6])
  p knight.find_path([6, 2])
end