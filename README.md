# CaVirtex

Gem to access ca_virtex API

## Installation

Add this line to your application's Gemfile:

    gem 'ca_virtex'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ca_virtex

## Usage

### Setup

```ruby
api_key = "XXXXXXXXXXXXXXXXXXXXXX"
api_secret = "XXXXXXXXXXXXXXXXXXXXXX"
@client = CaVirtex::API::Client.new(api_key, api_secret)
```

## Examples

### Balance

```ruby
@client.private.balance.balance.CAD
=> 50.0
```

### Orderbook

```ruby
orderbook = @client.public.orderbook(order_currency: :BTC, payement_currency: :CAD).orderbook

output = "Price      | Quantity  \n"
output += "-----------------------\n"
orderbook.asks.each do |ask|
  output += ask.price
  output += " | "
  output += ask.quantity
  output += "\n"
end

puts output

Price      | Quantity  
-----------------------
0.00131000 |     2618.0
0.00132000 |    20999.9
0.00132000 |    20000.0
0.00132000 |     1324.2
0.00133000 |    60000.0
0.00133000 |      100.0
0.00133000 |    56000.0
0.00134000 |   380000.0
0.00135000 |   988320.0
0.00137000 |   697000.0
```

### Place a Trade

```ruby
client.private.order(mode: "buy",price: "600.0", amount: "0.001", order_currency: :BTC, payment_currency: :CAD)

order.order["id"]
=> 594853
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/ca_virtex/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
