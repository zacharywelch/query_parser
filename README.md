# query_parser

```ruby
parser = Parser.new
pp parser.parse('show name, email from users by company since 2019-01-01 until -1d')

{:show=>[{:column=>"name"@5}, {:column=>"email"@11}],
 :from=>"users"@22,
 :by=>{:column=>"company"@31},
 :since=>"2019-01-01"@45,
 :until=>{:duration=>{:quantity=>"-1"@62, :unit=>"d"@64}}}
```
