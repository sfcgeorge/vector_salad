task default: %w(docgen)

task :clean do
  sh "git rm lib -rf"
end

task :source do
  sh "git checkout master -- lib"
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
  Rake::Task[:clean].execute
end

task :release do
  Rake::Task[:commit].execute
  Rake::Task[:push].execute
end
