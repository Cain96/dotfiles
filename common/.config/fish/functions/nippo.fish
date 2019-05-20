function nippo
  argparse -n nippo 'p/push' -- $argv
  or return 1

  set zatsuPath $WORKSPACE/zatsu
  set templatePath $zatsuPath/nippo_template.md
  set nippoDir $zatsuPath/nippo/
  set day (date "+%Y-%m-%d")
  set filename $day.md
  set filePath $nippoDir$filename

  if set -lq _flag_push
    set currentPath (pwd)
    cd $zatsuPath
    echo (pwd)

    git add $nippoDir
    git commit -m "nippo/$filename"
    gpush

    cd $currentPath
    return
  end

  if [ -f $filePath ]
    echo "today's nippo exists"
  else
    echo -e "- $day\n" > $filePath
    echo $templatePath
    cat $templatePath >> $filePath
    echo "create $filePath"
  end
  atom $filePath
end
