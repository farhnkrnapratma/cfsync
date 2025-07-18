#!/bin/nu

let src = ["aura/" "wezterm/" "nvim/" "nushell/" "cosmic/" "BetterDiscord/"] 
let dst = $env.CFG

print "\n :: RSYNC\n"

for $folder in $src {
  let fpath = ($dst | path join $folder)
  printf " :: Syncing folder '%s' with '%s'...\n\n" $fpath $folder
  rsync -av --delete $fpath $folder
  print "\n :: Done.\n"
}

rm -rf "nushell/history.txt"

let push_timestamp = (date now | format date "%F %T %z")

print " :: GIT\n"

git add .
git commit -m $"[($push_timestamp)] :: Sync new config\(s\) from localhost"
git push
