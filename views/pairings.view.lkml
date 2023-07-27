view: pairings {
  sql_table_name: "TRAINING_SOCCER"."PAIRINGS" ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }
  dimension: enemy_country_id {
    type: number
    sql: ${TABLE}."ENEMY_COUNTRY_ID" ;;
  }
  dimension_group: kickoff {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}."KICKOFF" ;;
  }
  dimension: my_country_id {
    type: number
    sql: ${TABLE}."MY_COUNTRY_ID" ;;
  }
  measure: count {
    type: count
    drill_fields: [id, goals.count]
  }
}
