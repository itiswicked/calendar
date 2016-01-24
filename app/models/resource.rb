class Resource < ActiveRecord::Base
  belongs_to :event
  belongs_to :inventory_item

  def is_lighting?
  end

  def is_sound?

  end

  def is_scenic?

  end

  def is_catering?

  end

  
end
