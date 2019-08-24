# query_parser

```ruby
parser = Parser.new
pp parser.parse("SHOW name, email_address AS 'email' FROM users BY company SINCE 2019-01-01 UNTIL -1d LIMIT 1000")

{:show=>
  [{:attribute=>"name"@5},
   {:attribute=>"email_address"@11, :label=>"email"@29}],
 :from=>"users"@41,
 :by=>{:attribute=>"company"@50},
 :since=>"2019-01-01"@64,
 :until=>{:duration=>{:quantity=>"-1"@81, :unit=>"d"@83}},
 :limit=>"1000"@91}
```
