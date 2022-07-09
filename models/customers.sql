with customers as (
    select * from analytics-engineers-club.coffee_shop.customers
),

orders as (
    select * from analytics-engineers-club.coffee_shop.orders
),

customer_orders as (
    select
        customer_id,
        count(*) as number_of_orders,
        min(created_at) as first_order_at
    from orders
    group by 1
),

joined as (
    select
        customers.id as customer_id,
        customers.name,
        customers.email,
        customer_orders.first_order_at,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers
    left join customer_orders
        on customers.id = customer_orders.customer_id
)

select * from joined
