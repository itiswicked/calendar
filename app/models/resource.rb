class Resource < ActiveRecord::Base
  belongs_to :event
  belongs_to :inventory_item

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :inventory_item_id, presence: true
  validates :event_id, presence: true

  def self.and_inventory_info(event_id)
    sql_query = <<-SQL
      SELECT
        resources.id,
        inventory_items.category,
        inventory_items.name,
        resources.quantity
      FROM
        "resources"
      INNER JOIN
        "inventory_items"
      ON
      "inventory_items"."id" = "resources"."inventory_item_id"
      WHERE "resources"."event_id" = ?;
    SQL
    ActiveRecord::Base.connection.execute(sanitize_sql([sql_query, event_id]))
  end
end
