require 'dotenv'
Dotenv.load

require 'rubygems'
require 'bundler/setup'
require 'thor'

require 'reports/github_api_client'
require 'reports/table_printer'

module Reports
  class CLI < Thor
    desc 'user_info USERNAME', 'Get information for a user'
    def user_info(username)
      puts "Getting info for #{username}..."

      data = client.user_info(username)

      puts "name: #{data.name}"
      puts "location: #{data.location}"
      puts "public repos: #{data.public_repos}"
    rescue Error => error
      puts "ERROR #{error.message}"
      exit 1
    end

    desc "console", "Open an RB session with all dependencies loaded and API defined."
    def console
      require 'irb'
      ARGV.clear
      IRB.start
    end

    private
      def client
        @client ||= GitHubAPIClient.new
      end
  end
end
