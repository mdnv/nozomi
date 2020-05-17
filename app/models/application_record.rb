class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  attr_accessor :is_submitted

  def savable?
    @is_submitted && valid?
  end

  def fetch_or_build(association_name)
    send(association_name).presence || send(association_name).build
  end

  def fetch_or_build_one(association_name)
    send(association_name).presence || send("build_#{association_name}")
  end
end
