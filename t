#!/bin/sh
# Summary: A simple task tracking utility
# Summary: based on Steve Losh's t
#alias t='python ~/bin/t --task-dir ~/.tasks --list tasks'
# TODO: running t without a list should not print error
#   prompt to create a list

usage(){
	printf '%s\n' "usage: t [-t DIR] [-l LIST] [options] [TEXT]"
	printf '%s\n' "Actions:"
	printf '%s\n\t%s\n' "-r, --remove" "remove TASK from list"
	printf '%s\n\t%s\n' "-e, --edit" "edit TASK to contain TEXT"
	printf '%s\n\t%s\n' "-f, --finish" "mark TASK as finished"

	printf '%s\n' "Config Options:"
	printf '%s\n\t%s\n' "-l, --list" "work on LIST"
	printf '%s\n\t%s\n' "-t, --task-dir" "work on the lists in DIR"

	printf '%s\n' "Output Options:"
	printf '%s\n\t%s\n' "-g, --grep" "print only tasks that contian WORD"
	printf '%s\n\t%s\n' "-v, --verbose" "print more detailed output"
	printf '%s\n\t%s\n' "-q, --quiet" "print less detailed output"
	printf '%s\n\t%s\n' "-d, --done" "list done tasks instead of unfinished ones"
}

while [ "$1" != "" ]; do
	case $1 in
		-r | --remove ) shift
			remove=$1
			;;
		-e | --edit ) shift
			edit=$1
			;;
		-f | --finish ) shift
			finish=$1
			;;
		-l | --list ) shift
			list=$1
			;;
		-t | --task-dir ) shift
			taskdir=$1
			;;
		-g | --grep ) shift
			grep=$1
			;;
		-v | --verbose ) shift
			verbose=$1
			;;
		-q | --quiet ) shift
			quiet=$1
			;;
		-d | --done ) shift
			done=$1
			;;
		-h | --help ) shift
			usage
			exit 0
			;;
		* )
			text="'$*'"
			break
	esac
	shift
done

# use defaults if needed
[ -z "$list" ] && list="tasks"
[ -z "$taskdir" ] && taskdir=~/.tasks/

# ID=45nl2nfwe2lkenf235wef FINISHED=true TEXT='asd kjlla lsvaw gavagg'
remove_task() {
	newtasklist=$(sed "/ID=$remove/d" "$taskdir$list")
	echo "$newtasklist" > "$taskdir$list"
}

edit_task() {
	# remove task then add task
	exit 1
}

finish_task() {
	# grep the id and mark finished field
	exit 1
}

add_task() {
	# genereate hash and insert line
	# needs to check for illegal text that would mess up the parser
	# should this check if there is a dup tasks already there?
	#TODO(ryan) handle directory not existing?
	id=$(echo "$text" | sha256sum | sed 's/\ .*//')
	echo "ID=$id FINISHED=false TEXT=$text" >> "$taskdir$list"
}

print_list() {
  if [ ! -f "$taskdir$list" ]; then
    mkdir -p "$taskdir"
    touch "$taskdir$list"
    echo "Created empty task list"
    return 0
  fi
	#TODO(ryan) this doesn't check finished/not-finished
	cat "$taskdir$list" | sed "s/ID=\([^\ ]\{3\}\).*FINISHED=false\ TEXT='\(.*\)'/\1 - \2/"
}

if [ ! -z "$remove" ]; then
	remove_task
elif [ ! -z "$edit" ]; then
	edit_task
elif [ ! -z "$finish" ]; then
	finish_task
elif [ ! -z "$text" ]; then
	add_task
else
	print_list
fi
