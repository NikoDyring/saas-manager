puts "Cleanup old seed data..."
Subscription.destroy_all
Vendor.destroy_all
User.destroy_all
Organization.destroy_all

puts "Creating organization..."
org = Organization.create!(name: 'Dyring Dev', slug: 'dyring-dev', plan: 'premium')

puts "Creating user..."
user = User.create!(organization: org, email: 'user@dyringdev.com', password: 'password', role: 'admin')

puts "Creating vendors..."
vendors = [
  { name: 'Slack', category: 'Communication' },
  { name: 'GitHub', category: 'DevTools' },
  { name: 'AWS', category: 'Infrastructure' },
  { name: 'Zoom', category: 'Communication' },
  { name: 'ChatGPT', category: 'AI Services' }
].map { |v| Vendor.create!(v) }

puts "Creating subscriptions..."
vendors.each do |vendor|
  Subscription.create!(
    organization: org,
    vendor: vendor,
    billing_cycle: [ 'monthly', 'annual' ].sample,
    amount_cents: rand(1000..10000),
    currency: 'DKK',
    renewal_date: Date.today + rand(30..365).days,
    status: 'active'
  )
end

puts "Seed complete! You now have an organization with 4 subscriptions."
