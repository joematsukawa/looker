view: test1 {
  sql_table_name: "TRAINING_SOCCER"."COUNTRIES" ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}

view: test2 {
  derived_table: {
    sql:
      SELECT
        *
      FROM
        "TRAINING_SOCCER"."COUNTRIES"
    ;;
  }
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}

include: "/views/countries.view.lkml"   # 継承元のファイル名

view: countries_inheritance {
  extends: [countries]  # 継承するview名

  dimension: id {hidden: yes} # この項目だけ表示させないなど再定義も可能

  # ※ここに定義をしていない項目も全て継承される
}
view: view_explanation {
  derived_table: {
    sql:
      SELECT
        *
      FROM
        "TRAINING_SOCCER"."PLAYERS"
      WHERE
        club = {% parameter parameter_club %}
    ;;
  }
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
  parameter: parameter_club {
    label: "クラブ(フィルター用)"
    type: string
    suggest_explore: players
    suggest_dimension: club
  }
}
view: view_explanation2 {
  derived_table: {
    sql:
      SELECT
        *
      FROM
        "TRAINING_SOCCER"."PLAYERS"
      WHERE
        {% condition filter_birth %} view_explanation2.birth {% endcondition %}
    ;;
  }
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
  filter: filter_birth {
    label: "誕生日(フィルター用)"
    type: date
    suggest_explore: players
    suggest_dimension: birth_date
  }
}
