task default: %w(release)

task :clean do
  sh "git rm lib -rf"
end

task :source do
  sh "git checkout master -- lib"
end

task :docs do
  sh "yard"
end

task :stats do
  sh "yard stats --list-undoc"
end

task :release do
  Rake::Task[:source].execute
  Rake::Task[:docs].execute
  Rake::Task[:clean].execute
end
