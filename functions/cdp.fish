function cdp
  set -l PROJECT $argv[1]

  if test -z $PROJECT
    echo "Usage: cdp <PROJECT>"
    return 1
  end

  set -l projects_type (ls ~/projects)

  if test -d ~/projects/$PROJECT
    if test "$PWD" = (realpath ~/projects/$PROJECT)
      echo "You are already in the directory ~/projects/$PROJECT"
      return 0
    end

    echo "Navigating to ~/projects/$PROJECT"
    cd ~/projects/$PROJECT
    return 0
  end

  set -l PROJECT_DIR (find ~/projects -maxdepth 2 -type d -not -path "*/.*" -iname "*$PROJECT*")

  if test -z "$PROJECT_DIR"
    echo "Project: $PROJECT not found."
    return 1
  end

  set -l DIR_COUNT (count $PROJECT_DIR)

  if test $DIR_COUNT -eq 1
    if test "$PWD" = "$PROJECT_DIR"
      echo "You are already in the directory ~/projects/"(basename (dirname $PROJECT_DIR))/(basename $PROJECT_DIR)
      return 0
    end

    cd $PROJECT_DIR
    echo "Navigating to ~/projects/"(basename (dirname $PROJECT_DIR))/(basename $PROJECT_DIR)
    return 0
  end

  echo "Multiple projects found:" \n

  for i in (seq $DIR_COUNT)
    echo "("$i")" (basename (dirname $PROJECT_DIR[$i])) "-" (basename $PROJECT_DIR[$i])
  end

  read -P \n"choose one: " CHOICE

  if test $CHOICE -gt 0 -a $CHOICE -le $DIR_COUNT
    if test "$PWD" = "$PROJECT_DIR[$CHOICE]"
      echo "You are already in the directory ~/projects/"(basename (dirname $PROJECT_DIR[$CHOICE]))/(basename $PROJECT_DIR[$CHOICE])
      return 0
    end

    echo "Navigating to ~/projects/"(basename (dirname $PROJECT_DIR[$CHOICE]))/(basename $PROJECT_DIR[$CHOICE])
    cd $PROJECT_DIR[$CHOICE]
    return 0
  else
    echo "Invalid choice."
    return 1
  end

  if test $status -ne 0
    echo "Something went wrong"
    return 1
  end
end
