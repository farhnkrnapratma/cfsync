#!/bin/nu

let srcf = $env.cfg
let dsts = ["starship.toml" "wezterm/" "nvim/" "nushell/" "cosmic/" "BetterDiscord/"] 

print "\n :: RSYNC\n"

for $dst in $dsts {
  let fpath = ($srcf | path join $dst)
  let target = ("target/" | path join $dst)
  printf " :: Syncing folder '%s' with '%s'...\n\n" $fpath $target
  rsync -av --delete $fpath $target
  print "\n :: Done.\n"
}

rm -rf "nushell/history.txt"

let push_timestamp = (date now | format date "%F %T %z")

print " :: GIT\n"

git add .
git commit -m $"[($push_timestamp)] :: Sync new config\(s\) from localhost"
git push
