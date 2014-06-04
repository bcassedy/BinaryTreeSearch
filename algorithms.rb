class TreeNode
  attr_accessor :value, :parent, :children
  def initialize(value, parent = nil, children = [nil, nil])
    @value = value
    @parent = parent
    @children = children
  end

  def remove_child(child_node)
    @children.delete(child_node)
    child_node.parent = nil
  end

  def add_child(child_node)
    unless child_node.parent.nil?
      child_node.parent.remove_child(child_node)
    end

    if child_node.value >= self.value
      if self.children[1].nil?
        self.children[1] = child_node
        child_node.parent = self
      else
        self.children[1].add_child(child_node)
      end
    else
      if self.children[0].nil?
        self.children[0] = child_node
        child_node.parent = self
      else
        self.children[0].add_child(child_node)
      end
    end

  end

  def dfs(find_value)
    if self.value == find_value
      return self
    end

    left_child = self.children[0]
    right_child = self.children[1]
    if left_child != nil
      return left_child.dfs(find_value)
    elsif right_child != nil
      right_result = right_child.dfs(find_value)
    end

    return left_result unless left_result.nil?
    return right_result unless right_result.nil?
    nil

  end


  def bfs(find_value)
    nodes_to_search = [self]
    until nodes_to_search.empty?
      current_node = nodes_to_search.shift
      if current_node.value == find_value
        return current_node
      else
        nodes_to_search << current_node.children[0] unless current_node.children[0].nil?
        nodes_to_search << current_node.children[1] unless current_node.children[1].nil?
      end
    end
    nil
  end


end
