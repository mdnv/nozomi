Ransack.configure do |c|
  c.custom_arrows = {
    up_arrow: '▲',
    down_arrow: '▼',
    default_arrow: ''
  }
  c.add_predicate 'end_of_day_lteq', arel_predicate: 'lteq', formatter: proc { |v| v.end_of_day }
  c.add_predicate 'beginning_of_day_gteq', arel_predicate: 'gteq', formatter: proc { |v| v.beginning_of_day }
end
