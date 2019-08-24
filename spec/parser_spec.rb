require 'spec_helper'

describe Parser do

  subject(:parser) { Parser.new }

  it 'parses query' do
    query = "SHOW name, email_address AS 'email' FROM users BY company SINCE 2019-01-01 UNTIL -1d LIMIT 1000"
    begin
      pp parser.parse(query)
    rescue Parslet::ParseFailed => error
      puts error.parse_failure_cause.ascii_tree
      raise
    end
  end

  describe 'space' do

    subject { parser.space }

    it { is_expected.to parse(' ') }
    it { is_expected.to parse(' ' * 10) }
  end

  describe 'space?' do

    subject { parser.space? }

    it { is_expected.to parse(' ') }
    it { is_expected.to parse('') }
  end

  describe 'comma' do

    subject { parser.comma }

    it { is_expected.to parse(',') }
    it { is_expected.to_not parse(' ,') }
  end

  describe 'attribute' do

    subject { parser.attribute }

    it { is_expected.to parse('*') }
    it { is_expected.to parse('foo') }
    it { is_expected.to parse('foo_bar') }
    it { is_expected.to parse("foo as 'bar'") }
    it { is_expected.to_not parse('foo bar') }
  end

  describe 'attributes' do

    subject { parser.attributes }

    it { is_expected.to parse('*') }
    it { is_expected.to parse('*, foo') }
    it { is_expected.to parse('foo, *') }
    it { is_expected.to parse('foo,bar') }
    it { is_expected.to parse('foo, bar') }
  end

  describe 'show' do

    subject { parser.show }

    it { is_expected.to parse('show *') }
    it { is_expected.to parse('show foo') }
    it { is_expected.to parse('show foo, bar') }
    it { is_expected.to parse('show foo ,bar, baz') }
  end
end
