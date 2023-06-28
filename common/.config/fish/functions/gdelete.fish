function gdelete
  set deleteBranches (git branch --merged | grep -vE '^\*|develop$|master$|main$' | sed "s/  *//g")
  set deleteRemoteBranches (git branch -r --merged | grep -vE '^\*|develop$|master$|main$' | sed "s/  *//g")
  set deleteBranchesCount (count $deleteBranches)
  set deleteRemoteBranchesCount (count $deleteRemoteBranches)

  if [ $deleteBranchesCount -gt 0 ]
    echo git branch -d $deleteBranches
    git branch -d $deleteBranches
  end

  if [ $deleteRemoteBranchesCount -gt 0 ]
    echo git branch -r -d $deleteRemoteBranches
    git branch -r -d $deleteRemoteBranches
  end

  if [ $deleteBranchesCount -eq 0 ] && [ $deleteRemoteBranchesCount -eq 0 ]
    echo "merged branch does not exist"
  end
end
