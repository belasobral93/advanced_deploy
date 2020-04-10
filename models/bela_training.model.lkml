# At least three Explores. Amongst the three, there should be:
# An Explore that is cached for 4 hours
# A join that uses the ‘fields’ parameter
# An Explore that uses the ‘always_filter’ parameter
# An Explore that uses the ‘sql_always_where’ parameter
# A join that uses the ‘view_label’ parameter
# A join that is an INNER join
# A view that is joined into the same Explore twice
#


connection: "thelook_events"

# include all the views
include: "/views/**/*.view"

datagroup: bela_training_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "4 hours"
}

persist_with: bela_training_default_datagroup


explore: bsandell {}

explore: company_list {}

explore: daily_active {}

explore: daily_activity {}

explore: distribution_centers {}

explore: events {
  persist_with: bela_training_default_datagroup
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: products {
  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }
}

explore: user_count_daily_rollup {}

explore: users {}

#
