# The name of this view in Looker is "Orders"
view: orders {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: demo_db.orders ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time

    timeframes: [raw, time,date, week, month, quarter, fiscal_year, day_of_week,year]

    sql: ${TABLE}.created_at ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Status" in Explore.

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }
  dimension: status1 {
    type: string
    sql: ${TABLE}.status ;;
  }

dimension: test {
    type: string
    sql: ${TABLE}.status ;;
  }

  # dimension: date1 {
  #   type: string

  #   sql:SELECT DATE("2017-06-15");;
  # }

  dimension: date_date {
    type: date
    sql: "2024-05-13";;
  }

  parameter: date_granularity {
    type: unquoted
    allowed_value: {
      label: " Date"
      value: "date"
    }
    allowed_value: {
      label: " Month"
      value: "month"
    }

    allowed_value: {
      label: " Year"
      value: "year"
    }

    allowed_value: {
      label: " Quarter"
      value: "quarter"
    }
    }


    parameter: date_granularity1 {
      type: unquoted
      allowed_value: {
        label: " Date"
        value: "date"
      }
      allowed_value: {
        label: " Month"
        value: "month"
      }

      allowed_value: {
        label: " Year"
        value: "year"
      }


    allowed_value: {
      label: " Quarter"
      value: "quarter"
    }
 }

  dimension: date {
    sql:
    {% if date_granularity._parameter_value == 'year' %}
      ${created_year}
    {% elsif date_granularity._parameter_value == 'month' %}
      ${created_month}
      {% elsif date_granularity._parameter_value == 'quarter' %}
      ${created_quarter}
      {% elsif date_granularity._parameter_value == 'date' %}
      ${created_date}
    {% else %}
      ${created_date}
    {% endif %};;
  }

    dimension: date1 {
      sql:
          {% if date_granularity1._parameter_value == 'year' %}
            ${created_year}
          {% elsif date_granularity1._parameter_value == 'month' %}
            ${created_month}
            {% elsif date_granularity1._parameter_value == 'quarter' %}
            ${created_quarter}
            {% elsif date_granularity1._parameter_value == 'date' %}
            ${created_date}
          {% else %}
            ${created_date}
          {% endif %};;
    }







  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count1{
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  users.id,
  users.first_name,
  users.last_name,
  billion_orders.count,
  fakeorders.count,
  hundred_million_orders.count,
  hundred_million_orders_wide.count,
  order_items.count,
  order_items_vijaya.count,
  ten_million_orders.count
  ]
  }

}
