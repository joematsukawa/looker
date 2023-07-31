# connection: "snowflake_traning"

# include: "/views/**/*.view.lkml"

# explore: test2{}

view: test1 {
  sql_table_name: "スキーマ名"."テーブル名" ;;
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
}

include: "/views/countries.view.lkml"   # 継承元のファイル名

view: countries_inheritance {
  extends: [countries]  # 継承するview名

  dimension: id {hidden: yes} # この項目だけ表示させないなど再定義も可能

  # ※ここに定義をしていない項目も全て継承される
}
