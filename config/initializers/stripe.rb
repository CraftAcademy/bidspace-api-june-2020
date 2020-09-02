Stripe.plan :bds_subscription_plan do |plan| 
  plan.name = 'Bidspace Subscription'
  plan.amount = 200
  plan.currency = 'usd'
  plan.interval = 'month'
  plan.interval_count = 12
end 