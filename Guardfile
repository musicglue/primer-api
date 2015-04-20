guard :minitest, all_on_start: false do
  watch(%r{^test/(.*)_test\.rb})

  watch(%r{^lib/(.+)\.rb}) { 'test' }
  watch(%r{^test/support/(.+)\.rb}) { 'test' }
  watch(%r{^test/test_helper\.rb}) { 'test' }
end

guard :rubocop, all_on_start: false, cli: ['--auto-correct'] do
  watch(%r{^lib/(.+)\.rb$})
  watch(%r{^test/(.+)\.rb$})
end
