function gdelete
  set deleteBranches (git branch --merged | grep -vE '^\*|develop$|master$' | sed "s/  *//g" )
  set deleteBranchesCount (count $deleteBranches)
  
  if [ $deleteBranchesCount -gt 0 ]
    echo git branch -d $deleteBranches
    git branch -d $deleteBranches
  else
    echo "merged branch does not exist"
  end
end
