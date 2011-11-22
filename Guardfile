guard 'cucumber', :cli => '--format pretty', :rvm => ['1.8.7', '1.9.3'] do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+\.rb$})          { 'features' }
  watch(%r{\.rb$}) { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
end
