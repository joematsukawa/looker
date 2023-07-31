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

view: dimension_test {
  sql_table_name: "TRAINING_SOCCER"."PLAYERS" ;;
  dimension: position_and_name{
    type: string
    sql: ${TABLE}."POSITION" || '-' || ${TABLE}."NAME" ;;
  }
  dimension_group: birth {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."BIRTH" ;;
  }
  dimension: age {
    type: number
    sql: timestampdiff(year,${birth_date},current_date());;
  }
  dimension: height_higher_175 {
    type: yesno
    sql: ${TABLE}."HEIGHT" > 175 ;;
  }
  dimension: height_tier {
    type:  tier
    tiers: [160,170,180,190]
    sql: ${TABLE}."HEIGHT" ;;
  }
}
