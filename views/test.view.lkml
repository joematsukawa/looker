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
