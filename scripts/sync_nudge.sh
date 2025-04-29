#!/data/data/com.termux/files/usr/bin/bash
TOKEN=$(cat ~/.github_token)
git pull https://$TOKEN@github.com/flypaper-creative/nudge.git
