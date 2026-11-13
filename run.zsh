#!/bin/zsh

scriptDir=${0:A:h}
savedFile="$scriptDir/python_target_file.txt"

setCommand() {
	local savedData=("${(@f)$(<"$savedFile")}") # split on newlines
	newData=""
	isExists=0
	file="./main.py" # Default
	for line in $savedData; do
		local array=("${(@s/:/)line}")
		local flag=0
		if [[ "${PWD:A}" == "$array[1]" ]]; then
			isExists=1
			file="$array[2]"
			if [[ -n "$1" ]]; then # $1 is a new command
				newData="$newData${array[1]}:${1}\n" # New command
				flag=1
			fi
		fi
		[[ "$flag" -eq 0 ]] && newData="$newData$line\n"
	done
}

save() {
	local fileName=${1:-./main.py}
	if [[ "$isExists" -eq 1 ]]; then # Already exists
		setCommand "$fileName"
		echo -en "$newData" > "$savedFile"
		echo "  Set file: ${fileName##*/}"
	else # Not found
		echo "${PWD:A}:${fileName:A}" >> "$savedFile"
		echo "  Set file: ${fileName##*/}"
	fi
}

[[ ! -f "$savedFile" ]] && echo "# You can manually add paths here." > "$savedFile"
setCommand
if [[ "${0##*/}" == "run" ]]; then
	[[ -d ".venv" ]] && source .venv/bin/activate # Activate venv
	if [[ -f "$file" ]]; then # File found
		echo "$file"
		python3 "$file" "$@"
	elif [[ "${file::3}" == "-m " ]]; then # Module
		echo "${file:3}"
		python3 -m "${file:3}" "$@"
	else
		echo "run: no such file or directory: "${file##*/}""
	fi
elif [[ "${0##*/}" == "runfile" ]]; then
	if [[ "$1" == "-h" ]]; then # Help
		echo "usage: runfile [-m] [-h] [file]"
	elif [[ "$1" == "-m" ]]; then # Module
		if [[ -n "$2" ]]; then
			save "-m $2"
		else
			echo "runfile: No input file"
		fi
	else
		save "${1:A}"
	fi
else
	echo "Something went wrong."
fi
