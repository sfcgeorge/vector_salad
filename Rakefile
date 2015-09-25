task default: %w(stats)

task :clean_lib do
  sh "git rm lib -rf --ignore-unmatch"
end

task :source do
  sh "git show master:README.md > README.md"

  Rake::Task[:clean_lib].execute
  sh "git checkout master -- lib"

  sh "git rm examples -rf --ignore-unmatch"
  sh "git checkout master -- examples"
end

task :commit do
  sh "git add --all"
  sh 'git commit -m "Update docs."'
end

task :push do
  sh "git push"
end

task :yard do
  sh "yard"
end

desc "Show YARD coverage stats"
task :stats do
  sh "yard stats --list-undoc"
end

desc "Generate documentation"
task :docgen do
  Rake::Task[:source].execute
  Rake::Task[:yard].execute
  Rake::Task[:clean_lib].execute
end

desc "Commit and push a doc update"
task :release do
  Rake::Task[:commit].execute
  Rake::Task[:push].execute
end
