view: calendar {
  derived_table: {
    sql:
      SELECT day FROM
      UNNEST(GENERATE_DATE_ARRAY(DATE('2021-01-01'), CURRENT_DATE(),
      INTERVAL 1 DAY)) AS day ;;
  }

  dimension_group: date {
    type:  time
    timeframes: [
      date,
      day_of_month,
      week,
      month,
      year
    ]
    sql: ${TABLE}.day ;;
  }

  dimension: date_join {
    sql: timestamp(${date_date}) ;;
  }

  measure: data_fim {
    type: date
    sql: max(${date_date}) ;;
  }



}
