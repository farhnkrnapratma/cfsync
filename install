#!/bin/nu

let src = ["wezterm/" "nvim/" "nushell" "cosmic" "BetterDiscord"]
let dst = $env.CFG

for $folder in $src {
  let fpath = ($dst | path join $folder)
  if ($fpath | path exists) {
    printf "Path '%s' exist. Removing..." $fpath
    rm -rf $fpath
    printf "Copying '%s' into '%s'" $folder $dst
    cp -r $folder $dst
  } else {
    printf "Copying '%s' into '%s'" $folder $dst
    cp -r $folder $dst
  }
}
