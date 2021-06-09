#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
tri=$'\uE0B0'
alias ls='ls --color=auto'
alias neofetch="neofetch | lolcat"
alias fuck_off="shutdown now"
#neofetch
#echo "i use arch BTW" | lolcat
# get current branch in git repo

function pgr() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo " [${BRANCH}${STAT}]"
	else
		echo ""
	fi
}
# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}
function nzr() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "[E$RETVAL] "
}
function ipa() {
ip -o -4 addr show up primary scope global | while read -r num dev fam addr rest; do
echo -n '['
echo -n ${dev}
echo -n ' '
echo -n ${addr%/*}
echo -n '] '
done

}

PS1="\[\e[1;31m\]\`nzr\`\[\e[1;35m\][\A]\[\e[1;36m\] \`ipa\`\[\e[1;32m\][\u@\h] \[\e[0;34m\]\W\`pgr\` \[\e[1;34m\]\$\[\e[m\] "
#function psl() {
#	echo -e "\033[1;31m\`nzr\`\033[0;36m[\A]"
#}
#function psr() {
#	echo -e "\033[1;35m\`ipa\`"
#}
#function prompt() {
#	comp=-9
#	PS1=$(printf "%*s\r%s"  "$(($(tput cols)+${comp}))" "$(psr)" "$(psl)")
#}
#PROMPT_COMMAND=prompt
