require 'parslet'

class Parser < Parslet::Parser
  root :query

  rule :query do
    show >> from >> group.maybe >> timerange.maybe
  end

  rule :show do
    stri('show') >> space >> columns.as(:show)
  end

  rule :from do
    stri('from') >> space >> schema.as(:from)
  end

  rule :group do
    stri('by') >> space >> columns.as(:by)
  end

  rule :timerange do
    since.maybe >> space? >> untill.maybe
  end

  rule :schema do
    identifier >> space?.ignore
  end

  rule :columns do
    column >> (comma >> column).repeat
  end

  rule :column do
    (identifier | star).as(:column) >> space?
  end

  rule :since do
    stri('since') >> space >> date.as(:since)
  end

  rule :untill do
    stri('until') >> space >> date.as(:until)
  end

  rule :date do
    explicit_date | relative_date
  end

  rule :explicit_date do
    digits(4) >> dash >> digits(2) >> dash >> digits(2)
  end

  rule :relative_date do
    dash >> digit.repeat(1) >> match('[dwmy]')
  end

  rule :identifier do
    match('[a-zA-Z]') >> match('\w').repeat
  end

  rule :star do
    str('*')
  end

  rule :comma do
    str(',') >> space?
  end

  rule :dash do
    str('-')
  end

  rule :digit do
    match('\d')
  end

  rule :space? do
    space.maybe
  end

  rule :space do
    match('\s').repeat(1)
  end

  private

  def stri(str)
    chars = str.split(//)
    chars.collect! { |ch| match["#{ch.upcase}#{ch.downcase}"] }.reduce(:>>)
  end

  def digits(n)
    digit.repeat(n, n)
  end
end