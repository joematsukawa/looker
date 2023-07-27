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
  dimension: goal_time_number {
    type: number
    sql: case
          when ${goal_time} like "前半_分" then cast(substr(${goal_time},3,1) as number)
          when ${goal_time} like "前半%分" then cast(substr(${goal_time},3,2) as number)
          when ${goal_time} like "後半_分" then cast(substr(${goal_time},3,1) as number) + 45
          when ${goal_time} like "後半%分" then cast(substr(${goal_time},3,2) as number) + 45
        end;;
  }
  dimension: goal_time_group {
    type: yesno
    sql: ${goal_time} like "前半%" or ${goal_time} like "延前%" ;;
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
  measure: goal_players_count {
    type: count_distinct
    sql: ${player_id};;
  }
  measure: count_goals_time_before {
    type: count
    filters: {
      field: goal_time_group
      value: "yes"
    }
  }
  measure: count_goals_time_after {
    type: count
    filters: {
      field: goal_time_group
      value: "no"
    }
  }
  measure: ave_goal_time {
    type: average
    sql: ${goal_time_number} ;;
  }

}
