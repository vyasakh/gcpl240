# The name of this view in Looker is "Order Items"
view: order_items {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Inventory Item ID" in Explore.

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  parameter: exclude_royalties {
    view_label: " Revenue metrics"
    type: number
    #default_value: "1"
    description: "Filter to include/exclude royalties, default is NO"
    label: "Exclude royalties?"
    allowed_value: {
      label: "Include royalties"
      value: "1"
    }
    allowed_value: {
      label: "Exclude royalties"
      value: "0"
    }
  }
  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }



  dimension: phones {
    type: string
    sql: ${TABLE}.phones ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: returned {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.returned_at ;;
  }

  measure: returned_at{
    type: median
    sql:  ${returned_time}/86400.0 ;;
    value_format: "hh:mm:ss"
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;  }
  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;  }
  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
}
