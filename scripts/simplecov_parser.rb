#!/usr/bin/env ruby

# SimpleCov Coverage Parser
# =========================
#
# Command-line tool to parse SimpleCov HTML coverage reports into text format.
#
# Features:
# - Parse SimpleCov HTML files into structured text output
# - Display overall coverage statistics with file counts and percentages
# - Group analysis by Rails conventions (Controllers, Models, Helpers, etc.)
# - File-level details with line and branch coverage metrics
# - Identify uncovered and partially covered lines with specific line numbers
# - Branch coverage analysis when available
# - Focused mode to show only files with coverage issues
# - Smart file discovery with common path fallbacks
#
# Requirements:
# - Ruby (any recent version)
# - nokogiri gem: gem install nokogiri
#
# Usage Examples:
#   ./simplecov_parser.rb                          # Parse ./coverage/index.html
#   ./simplecov_parser.rb coverage/index.html      # Parse specific file
#   ./simplecov_parser.rb -u                       # Show only uncovered files
#   ./simplecov_parser.rb -d reports/coverage      # Use different directory
#   ./simplecov_parser.rb -f custom_coverage.html  # Use different HTML file
#
# Use cases:
# - CI/CD pipelines to identify testing gaps
# - Code reviews focusing on coverage issues
# - Development workflow to track testing progress
# - Converting HTML reports for text-based tools and contexts

require 'nokogiri'
require 'optparse'

class SimpleCovParser
  def initialize(html_file)
    @html_file = html_file
    @doc = nil
    @options = {}
  end

  def parse(options = {})
    @options = options
    
    File.open(@html_file, 'r') do |file|
      @doc = Nokogiri::HTML(file)
    end

    if @options[:uncovered_only]
      puts "SimpleCov Coverage Report - Uncovered Issues Only"
      puts "=" * 55
      parse_uncovered_only
    else
      puts "SimpleCov Coverage Report"
      puts "=" * 50
      parse_summary
      parse_groups
    end
  rescue => e
    puts "Error parsing coverage file: #{e.message}"
    exit 1
  end

  private

  def parse_summary
    timestamp = @doc.css('.timestamp abbr').first&.attribute('title')&.value
    puts "Generated: #{timestamp}" if timestamp

    all_files_section = @doc.css('#AllFiles').first
    return unless all_files_section

    coverage_percent = all_files_section.css('.covered_percent .green').first&.text&.strip
    hits_per_line = all_files_section.css('.covered_strength .green').first&.text&.strip
    total_files = all_files_section.css('div').find { |div| div.text.match(/\d+ files in total/) }&.text&.match(/(\d+)/)[1]

    line_summary = all_files_section.css('.t-line-summary').first
    if line_summary
      relevant_lines = line_summary.css('b').first&.text
      covered_lines = line_summary.css('.green b').first&.text
      missed_lines = line_summary.css('.red b').first&.text
    end

    branch_summary = all_files_section.css('.t-branch-summary').first
    if branch_summary
      total_branches = branch_summary.css('b').first&.text
      covered_branches = branch_summary.css('.green b').first&.text
      missed_branches = branch_summary.css('.red b').first&.text
    end

    puts "\nOverall Coverage:"
    puts "  Files: #{total_files}"
    puts "  Line Coverage: #{coverage_percent} (#{covered_lines}/#{relevant_lines} lines)"
    puts "  Branch Coverage: #{branch_summary ? calculate_branch_percentage(covered_branches, total_branches) : 'N/A'} (#{covered_branches}/#{total_branches} branches)" if branch_summary
    puts "  Average Hits/Line: #{hits_per_line}"
    puts
  end

  def parse_groups
    group_sections = @doc.css('.file_list_container').select do |section|
      group_name = section.css('.group_name').first&.text
      group_name && group_name != 'All Files'
    end

    group_sections.each do |section|
      parse_group(section)
    end
  end

  def parse_group(section)
    group_name = section.css('.group_name').first&.text
    
    # In uncovered-only mode, check if group has any issues before showing
    if @options[:uncovered_only]
      files = section.css('.file_list tbody .t-file')
      has_issues = files.any? do |file_row|
        missed_lines = file_row.css('.cell--number')[4]&.text&.strip
        missed_branches = file_row.css('.cell--number')[9]&.text&.strip
        missed_lines.to_i > 0 || missed_branches.to_i > 0
      end
      return unless has_issues
    end

    puts "Group: #{group_name}"
    puts "-" * (group_name.length + 7)

    unless @options[:uncovered_only]
      coverage_percent = section.css('.covered_percent .green').first&.text&.strip
      hits_per_line = section.css('.covered_strength .green').first&.text&.strip

      line_summary = section.css('.t-line-summary').first
      if line_summary
        relevant_lines = line_summary.css('b').first&.text
        covered_lines = line_summary.css('.green b').first&.text
        missed_lines = line_summary.css('.red b').first&.text
      end

      branch_summary = section.css('.t-branch-summary').first
      if branch_summary
        total_branches = branch_summary.css('b').first&.text
        covered_branches = branch_summary.css('.green b').first&.text
        missed_branches = branch_summary.css('.red b').first&.text
      end

      puts "  Summary: #{coverage_percent} line coverage, #{hits_per_line} hits/line"
      puts "  Lines: #{covered_lines}/#{relevant_lines} covered"
      puts "  Branches: #{covered_branches}/#{total_branches} covered" if branch_summary
      puts
    end

    files = section.css('.file_list tbody .t-file')
    files.each do |file_row|
      parse_file_summary(file_row)
    end

    puts
  end

  def parse_file_summary(file_row)
    file_link = file_row.css('.t-file__name a').first
    file_path = file_link&.attribute('title')&.value
    file_id = file_link&.attribute('href')&.value&.gsub('#', '')

    coverage_percent = file_row.css('.t-file__coverage').first&.text&.strip
    line_count = file_row.css('.cell--number')[1]&.text&.strip
    relevant_lines = file_row.css('.cell--number')[2]&.text&.strip
    covered_lines = file_row.css('.cell--number')[3]&.text&.strip
    missed_lines = file_row.css('.cell--number')[4]&.text&.strip
    avg_hits = file_row.css('.cell--number')[5]&.text&.strip

    branch_coverage = file_row.css('.t-file__branch-coverage').first&.text&.strip
    total_branches = file_row.css('.cell--number')[7]&.text&.strip
    covered_branches = file_row.css('.cell--number')[8]&.text&.strip
    missed_branches = file_row.css('.cell--number')[9]&.text&.strip

    # Skip files with perfect coverage in uncovered-only mode
    if @options[:uncovered_only]
      has_uncovered_lines = missed_lines.to_i > 0
      has_uncovered_branches = missed_branches.to_i > 0
      return unless has_uncovered_lines || has_uncovered_branches
    end

    puts "  #{file_path}"
    puts "    Line Coverage: #{coverage_percent} (#{covered_lines}/#{relevant_lines})"
    puts "    Branch Coverage: #{branch_coverage} (#{covered_branches}/#{total_branches})" if total_branches.to_i > 0
    puts "    Average Hits: #{avg_hits}"

    if file_id
      parse_file_details(file_id, file_path)
    end
  end

  def parse_file_details(file_id, file_path)
    source_table = @doc.css("##{file_id}").first
    return unless source_table

    lines = source_table.css('li')
    uncovered_lines = []
    partial_lines = []

    lines.each do |line|
      line_number = line.attribute('data-linenumber')&.value
      line_class = line.attribute('class')&.value

      next unless line_number

      case line_class
      when 'missed'
        uncovered_lines << line_number
      when 'partial'
        partial_lines << line_number
      end
    end

    if !uncovered_lines.empty? || !partial_lines.empty?
      puts "    Issues:"
      puts "      Uncovered lines: #{uncovered_lines.join(', ')}" unless uncovered_lines.empty?
      puts "      Partially covered lines: #{partial_lines.join(', ')}" unless partial_lines.empty?
    end
  end

  def parse_uncovered_only
    timestamp = @doc.css('.timestamp abbr').first&.attribute('title')&.value
    puts "Generated: #{timestamp}" if timestamp

    all_files_section = @doc.css('#AllFiles').first
    if all_files_section
      line_summary = all_files_section.css('.t-line-summary').first
      branch_summary = all_files_section.css('.t-branch-summary').first
      
      missed_lines = line_summary&.css('.red b')&.first&.text || "0"
      missed_branches = branch_summary&.css('.red b')&.first&.text || "0"

      total_issues = missed_lines.to_i + missed_branches.to_i
      
      if total_issues == 0
        puts "\nPerfect coverage! No uncovered lines or branches found."
        return
      else
        puts "\nFound #{missed_lines} uncovered lines and #{missed_branches} uncovered branches:"
        puts
      end
    end

    parse_groups
  end

  def calculate_branch_percentage(covered, total)
    return "0.0%" if total.to_i == 0
    percentage = (covered.to_f / total.to_f * 100).round(1)
    "#{percentage}%"
  end
end

def show_help
  puts <<~HELP
    SimpleCov Coverage Parser

    USAGE:
        #{$0} [OPTIONS] [COVERAGE_FILE]

    DESCRIPTION:
        Parses SimpleCov HTML coverage files into digestible text format.
        Includes file paths, line coverage, branch coverage, groups, and detailed line information.

    OPTIONS:
        -d, --directory DIR     Coverage directory (default: ./coverage)
        -f, --file FILE         Coverage HTML file (default: index.html)
        -u, --uncovered-only    Show only files with uncovered lines/branches
        -h, --help              Show this help message
        -v, --verbose           Show verbose output (currently same as default)

    EXAMPLES:
        #{$0}                           # Parse ./coverage/index.html
        #{$0} coverage/index.html       # Parse specific file
        #{$0} -d reports/coverage       # Use different coverage directory
        #{$0} -u                        # Show only uncovered files
        #{$0} -f custom.html            # Use different HTML file

    REQUIREMENTS:
        - Ruby (any recent version)
        - nokogiri gem (gem install nokogiri)
  HELP
end

def find_coverage_file(directory, filename)
  path = File.join(directory, filename)
  return path if File.exist?(path)
  
  # Try some common variations
  variations = [
    File.join(directory, 'index.html'),
    File.join('.', 'coverage', 'index.html'),
    File.join('.', 'coverage_reports', 'index.html')
  ]
  
  variations.find { |variation| File.exist?(variation) }
end

# Main execution
options = { verbose: false, uncovered_only: false }
coverage_dir = 'coverage'
coverage_file = 'index.html'
target_file = nil

OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [options] coverage_file.html"
  
  opts.on("-d", "--directory DIR", "Coverage directory") do |dir|
    coverage_dir = dir
  end
  
  opts.on("-f", "--file FILE", "Coverage HTML file") do |file|
    coverage_file = file
  end
  
  opts.on("-v", "--verbose", "Show verbose output") do
    options[:verbose] = true
  end
  
  opts.on("-u", "--uncovered-only", "Show only files with uncovered lines/branches") do
    options[:uncovered_only] = true
  end
  
  opts.on("-h", "--help", "Show this help message") do
    show_help
    exit
  end
end.parse!

# Determine the coverage file to parse
if ARGV.length > 0
  target_file = ARGV[0]
  unless File.exist?(target_file)
    puts "Error: File '#{target_file}' not found"
    exit 1
  end
else
  target_file = find_coverage_file(coverage_dir, coverage_file)
  unless target_file
    puts "Error: Coverage file not found"
    puts "Tried looking for:"
    puts "  #{File.join(coverage_dir, coverage_file)}"
    puts "  ./coverage/index.html"
    puts "  ./coverage_reports/index.html"
    puts
    puts "Make sure you have run your test suite with SimpleCov enabled."
    exit 1
  end
end

# Check dependencies
begin
  require 'nokogiri'
rescue LoadError
  puts "Error: nokogiri gem not found. Please install it with: gem install nokogiri"
  exit 1
end

puts "Parsing coverage file: #{target_file}"
puts

parser = SimpleCovParser.new(target_file)
parser.parse(options) 
