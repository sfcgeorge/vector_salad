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

task :guide_render do
  require_relative "guide_render"
  GuideRender.new("GETTING_STARTED.markdown").render
end

task :yard do
  sh "yard"
  # Yard produces a stupid _index.html that stupid GitHub doesn't like
  # so we have to change it using sed which has stupid encoding problems
  # and stupid OS X does stupid things with -i so it might break on Linux
  # in fact this is so horrible it needs a safety pig, enjoy:
  #
  #	 _._ _..._ .-',     _.._(`))
  #	'-. `     '  /-._.-'    ',/
  #	   )         \            '.
  #	  / _    _    |             \
  #	 |  a    a    /              |
  #	 \   .-.                     ;
  #	  '-('' ).-'       ,'       ;
  #	     '-;           |      .'
  #	        \           \    /
  #	        | 7  .__  _.-\   \
  #	        | |  |  ``/  /`  /
  #	       /,_|  |   /,_/   /
  #	          /,_/      '`-'
  #
  #	You are safe now.
  sh "LANG=C LC_CTYPE=C LC_ALL=C find ./doc -type f -exec sed -i '' 's/_index\\.html/contents\\.html/g' '{}' \\;"
  sh "mv doc/_index.html doc/contents.html"
end

desc "Show YARD coverage stats"
task :stats do
  sh "yard stats --list-undoc"
end

desc "Generate documentation"
task :docgen do
  Rake::Task[:source].execute
  Rake::Task[:guide_render].execute
  Rake::Task[:yard].execute
  Rake::Task[:clean_lib].execute
end

desc "Commit and push a doc update"
task :release do
  Rake::Task[:commit].execute
  Rake::Task[:push].execute
end
