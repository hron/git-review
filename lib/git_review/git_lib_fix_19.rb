require 'git/lib'

# https://github.com/schacon/ruby-git/pull/35
class Git::Lib
  def config_get(name)
    do_get = lambda do |path|
      command('config', ['--get', name])
    end

    if @git_dir
      Dir.chdir(@git_dir, &do_get)
    else
      build_list.call
    end
  end
end
