require "open3"
require "digest"

require "jekyll"

module Jekyll
  module Agda
    class Runner
      RE_LAGDA_MD_EXT = /\.lagda\.md$/i
      RE_AGDA_GENERATED_HTML_PATH = /(?<=\().*?.html(?=\))/

      attr_reader :source, :target, :dependencies, :successful

      def initialize(resource, work_dir)
        @resource = resource
        @source = Pathname.new(@resource.path)
        @work_dir = Pathname.new(work_dir)
        @digest = @work_dir.join(@source.basename.sub(RE_LAGDA_MD_EXT, ".md5"))
        @target = @work_dir.join(@source.basename.sub(RE_LAGDA_MD_EXT, ".md"))
        @dependencies = []
        @successful = nil
      end

      def execute
        old_hash = @digest.exist? ? @digest.read : nil
        new_hash = Digest::MD5.hexdigest(@resource.content)
        return if new_hash == old_hash

        log_takeoff
        stdout, _stderr, status = run_agda

        if (@successful = status.success?)
          @digest.write(new_hash)
          @dependencies = stdout.scan(RE_AGDA_GENERATED_HTML_PATH)
          log_success
        else
          log_failure
        end
      end

      private

      def run_agda
        Open3.capture3(
          [
            "agda",
            "--html",
            "--html-highlight=auto",
            "--html-dir=#{@work_dir.tap(&:mkpath).realpath}",
            @source.basename,
          ].join(" "),
          chdir: @source.dirname,
        )
      end

      def log_takeoff
        Jekyll.logger.writer << "Running Agda: ".rjust(20)
        Jekyll.logger.writer << "??".yellow + " " + @resource.relative_path
      end

      def log_success
        Jekyll.logger.writer << "\b" * @resource.relative_path.length
        Jekyll.logger.writer << "\b" * 3 + "OK".green + "\n"
      end

      def log_failure
        Jekyll.logger.writer << "\b" * @resource.relative_path.length
        Jekyll.logger.writer << "\b" * 3 + "KO".red + "\n"
      end
    end
  end
end
