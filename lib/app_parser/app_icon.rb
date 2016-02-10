module AppParser::AppIcon
  def icon(dimensions:)
    dimensions = [dimensions, dimensions] unless dimensions.is_a? Array
    icons.find { |icon| icon[:dimensions] == dimensions }
  end

  def largest_icon
    sorted_icons.last
  end

  def smallest_icon
    sorted_icons.first
  end

  def sorted_icons
    icons.sort_by { |icon| icon[:dimensions].first * icon[:dimensions].last }
  end
end
