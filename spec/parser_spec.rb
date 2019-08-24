require 'spec_helper'

describe Parser do

  subject(:parser) { Parser.new }

  it 'parses query' do
    query = 'show name, email from users by company since 2019-01-01 until -1d'
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

  describe 'column' do

    subject { parser.column }

    it { is_expected.to parse('foo') }
    it { is_expected.to parse('foo_bar') }
    it { is_expected.to_not parse('foo bar') }
  end

  describe 'columns' do

    subject { parser.columns }

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
