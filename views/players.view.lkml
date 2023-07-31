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
  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }
  dimension: position {
    type: string
    sql: ${TABLE}."POSITION" ;;
  }
  dimension: uniform_num {
    type: number
    sql: ${TABLE}."UNIFORM_NUM" ;;
  }
  dimension: weight {
    type: number
    sql: ${TABLE}."WEIGHT" ;;
  }
  dimension: position_and_name{
    type: string
    sql: ${position} || '-' || ${name} ;;
  }
  dimension: age {
    type: number
    sql: timestampdiff(year,${birth_date},current_date());;
  }
  dimension: height_higher_175 {
    type: yesno
    sql: ${height} > 175 ;;
  }
  dimension: height_tier {
    type:  tier
    tiers: [160,170,180,190]
    sql: ${height} ;;
  }
  measure: count {
    type: count
    drill_fields: [id, position,name, goals.count]
  }
  measure: count_age {
    type: count
    drill_fields: [age]
    }
  measure: avg_weight_arsenal {
    type: average
    sql: ${weight};;
    filters: [club: "アーセナル"]
  }
  measure: avg_height_arsenal {
    type: average
    sql: ${height} ;;
    filters: [club: "アーセナル"]
  }
  measure: avg_bmi_arsenal {
    type: average
    sql: ${weight} / power(${height}/100,2);;
    filters: [club: "アーセナル"]
  }
}

view: view_explanation {
  derived_table: {
    sql:
      SELECT
        *
      FROM
        "TRAINING_SOCCER"."COUNTRIES"
      WHERE
        club = {% parameter parameter_club %}
    ;;
  }
  dimension: club {
    type: string
    sql: ${TABLE}."CLUB" ;;
  }
  parameter: parameter_club {
    label: "クラブ(フィルター用)"
    type: string
    suggest_dimension: club
  }
}
