view: countries {
  sql_table_name: "TRAINING_SOCCER"."COUNTRIES" ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }
  dimension: group_name {
    type: string
    sql: ${TABLE}."GROUP_NAME" ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }
  dimension: ranking {
    type: number
    sql: ${TABLE}."RANKING" ;;
  }
  measure: count {
    type: count
    drill_fields: [id, group_name, name]
  }
}
