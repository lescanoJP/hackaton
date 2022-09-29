module Git
  module Danger
    module Helper
      CATEGORIES = {
        %r{\A(ee/)?db/} => :ignore,
        %r{\A(ee/)?features/step_definitions/} => :ignore,
        %r{\A(features/support/env|spec/rails_helper)(/|\.rb)} => :ignore,
        %r{\A(ee/)?(app/channels/|test/)/} => :ignore,
        %r{\A(ee/)?app/services/(updates)/} => :ignore,
        %r{\A(ee/)?lib/(tasks|spotify|assets|mocks)/} => :ignore,
        %r{\A(ee/)?(bin|config|danger|rubocop|scripts)/} => :ignore,
        %r{\A(Dangerfile|Gemfile|Gemfile.lock|Rakefile|\.gitlab-ci\.yml|\.gitignore|erd\.pdf)\z} => :ignore
      }.freeze

      def all_changed_files
        Set.new
           .merge(git.added_files.to_a)
           .merge(git.modified_files.to_a)
           .merge(git.renamed_files.map { |x| x[:after] })
           .subtract(git.renamed_files.map { |x| x[:before] })
           .to_a
           .sort
      end

      def changes_by_category
        all_changed_files.each_with_object(Hash.new { |h, k| h[k] = [] }) do |file, hash|
          hash[category_for_file(file)] << file
        end
      end

      def category_for_file(file)
        _, category = CATEGORIES.find { |regexp, _| regexp.match?(file) }
        category || :to_avaliate
      end

      def to_avaliate_files
        changes_by_category[:to_avaliate]
      end
    end
  end
end
