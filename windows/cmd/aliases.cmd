@echo off
doskey ls=dir /P $*
doskey cwd=cd
doskey cd=pushd $*
doskey back=popd
doskey cp=copy $*
doskey rm=del $*
doskey mv=move $*
doskey psh=powershell
doskey ydl = youtube-dl -F $1
doskey ydf = youtube-dl -f $*
doskey ydd = youtube-dl -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4 $*
doskey scrcpy2 = scrcpy -b2M -m800 --max-fps 30