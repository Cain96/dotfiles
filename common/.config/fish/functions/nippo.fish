function nippo
  set zatsuPath $WORKSPACE/zatsu
  set templatePath $zatsuPath/nippo_template.md
  set nippoDir $zatsuPath/nippo/
  set day (date "+%Y-%m-%d")
  set filename $day.md
  set filePath $nippoDir$filename

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
