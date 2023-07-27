view: goals {
  sql_table_name: "TRAINING_SOCCER"."GOALS" ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }
  dimension: goal_time {
    type: string
    sql: ${TABLE}."GOAL_TIME" ;;
  }
  dimension: pairing_id {
    type: string
    # hidden: yes
    sql: ${TABLE}."PAIRING_ID" ;;
  }
  dimension: player_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."PLAYER_ID" ;;
  }
  measure: count {
    type: count
    drill_fields: [id, players.id, players.name, pairings.id]
  }
}
