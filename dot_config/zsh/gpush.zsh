function gpush() {
  local currentBranch=$(git branch --show-current)
  echo git push $@ -u origin $currentBranch

  if [[ $currentBranch == "master" ]]; then
    read -q "choice?Your branch is main. push origin main? (Y/n): "
    echo ""
    if [[ $choice == "Y" || $choice == "y" ]]; then
      git push $@ -u origin $currentBranch
    else
      echo "canceled push"
    fi
  else
    git push $@ -u origin $currentBranch
  fi
}
