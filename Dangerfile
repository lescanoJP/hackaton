require 'json'
require 'rails'
require 'byebug'

danger.import_plugin('danger/plugins/helper.rb')

to_avaliate_files = helper.to_avaliate_files
# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example

declared_trivial = gitlab.pr_title.include? "#trivial"
if gitlab.mr_title.include?("[WIP]") || gitlab.mr_title.include?("WIP:")
  return
end

# Mainly to encourage writing up some reasoning about the PR, rather than
# just leaving a title
if gitlab.pr_body.length < 5
  fail "Please provide a summary in the Pull Request description"
end

# # TESTING VALIDATION

NO_SPECS_LABELS = %w[backstage Documentation QA].freeze
NO_NEW_SPEC_MESSAGE = <<~MSG.freeze
You've made some app changes, but didn't add any tests.
That's OK as long as you're refactoring existing code,
but please consider adding any of the %<labels>s labels.
MSG

def presented_no_changelog_labels
  NO_SPECS_LABELS.map { |label| "~#{label}" }.join(', ')
end

has_app_changes = !helper.all_changed_files.grep(%r{\A(ee/)?(app/services)/}).empty?
has_spec_changes = !helper.all_changed_files.grep(%r{\A(ee/)?features/}).empty?
new_specs_needed = (gitlab.mr_labels & NO_SPECS_LABELS).empty?

if has_app_changes && !has_spec_changes && new_specs_needed
  warn format(NO_NEW_SPEC_MESSAGE, labels: presented_no_changelog_labels), sticky: false
end

# RUBOCOP AND REEK
files_to_correct = { files: to_avaliate_files, inline_comment: true }

rubocop.lint files_to_correct

#reek.lint (git.modified_files + git.added_files) # TODO: Configurar Reek, desabilitado por hora
