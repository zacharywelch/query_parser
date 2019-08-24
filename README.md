# query_parser

```ruby
parser = Parser.new
pp parser.parse('SHOW name, email FROM users BY company SINCE 2019-01-01 UNTIL -1d LIMIT 1000')

{:show=>[{:column=>"name"@5}, {:column=>"email"@11}],
 :from=>"users"@22,
 :by=>{:column=>"company"@31},
 :since=>"2019-01-01"@45,
 :until=>{:duration=>{:quantity=>"-1"@62, :unit=>"d"@64}},
 :limit=>"1000"@72}
```
