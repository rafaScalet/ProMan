function lap
  if test (count $argv[1]) -eq 0
    for dir in ~/projects/*/
      set -l project_dir $HOME/projects/
      set -l type (string replace $project_dir '' $dir)
      echo $type | sed 's/\///g'
      ls -1 $dir
      echo
    end
    return
  end

  set -l project_technology $argv[1]
  ls -1 ~/projects/$project_technology
end
