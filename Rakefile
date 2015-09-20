task default: %w(docgen)

task :clean_lib do
  sh "git rm lib -rf --ignore-unmatch"
end

task :source do
  Rake::Task[:clean_lib].execute
  sh "git checkout master -- lib"

  sh "git rm examples -rf --ignore-unmatch"
  sh "git checkout master -- examples"
end

task :commit do
  sh 'git commit -am "Update docs."'
end

task :push do
  sh "git push"
end

task :yard do
  sh "yard"
end

task :stats do
  sh "yard stats --list-undoc"
end

task :docgen do
  Rake::Task[:source].execute
  Rake::Task[:yard].execute
  Rake::Task[:clean_lib].execute
end

task :release do
  Rake::Task[:commit].execute
  Rake::Task[:push].execute
end
