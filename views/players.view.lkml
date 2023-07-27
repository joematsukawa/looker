view: players {
  sql_table_name: "TRAINING_SOCCER"."PLAYERS" ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }
  dimension_group: birth {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."BIRTH" ;;
  }
  dimension: NextBirthday {
    type: number
    sql: DATEDIFF(day,current_date, ${TABLE}."BIRTH") ;;
  }
  dimension: club {
    type: string
    sql: ${TABLE}."CLUB" ;;
  }
  dimension: country_id {
    type: number
    sql: ${TABLE}."COUNTRY_ID" ;;
  }
  dimension: height {
    type: number
    sql: ${TABLE}."HEIGHT" ;;
  }
  dimension: height_is_higher_than_175 {
    type: yesno
    sql: ${TABLE}."HEIGHT" > 175 ;;
  }
  dimension: position_and_name {
    type: string
    sql: ${TABLE}."POSITION" || "," || ${TABLE}."NAME"  ;;
  }
  # dimension: name {
  #   type: string
  #   sql: ${TABLE}."NAME" ;;
  # }
  # dimension: position {
  #   type: string
  #   sql: ${TABLE}."POSITION" ;;
  # }
  dimension: uniform_num {
    type: number
    sql: ${TABLE}."UNIFORM_NUM" ;;
  }
  dimension: weight {
    type: number
    sql: ${TABLE}."WEIGHT" ;;
  }
  measure: count {
    type: count
    drill_fields: [id, position_and_name, goals.count]
  }
}
