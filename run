#!/bin/zsh

scriptDir=${0:A:h}
savedFile="$scriptDir/python_target_file.txt"

setCommand() {
	local savedData=("${(@f)$(<"$savedFile")}") # split on newlines
	newData=""
	isExists=0
	file="./main.py" # Default
	for line in $savedData; do
		local arr=("${(@s/:/)line}")
		if [[ "${PWD:A}" == "$arr[1]" ]]; then
			isExists=1
			file="$arr[2]"
			if [[ -n "$1" ]]; then
				newData="$newData${arr[1]}:${1:A}\n" # New command
			else
				newData="$newData$line\n"
			fi
		else
			newData="$newData$line\n"
		fi
	done
}

save() {
	if [[ "$isExists" -eq 1 ]]; then # Already exists
		if [[ -n "$1" ]]; then
			setCommand "$1"
			echo -en "$newData" > "$savedFile"
			echo "  Set file: $1"
		else
			setCommand "./main.py"
			echo -en "$newData" > "$savedFile"
			echo "  Set file: ./main.py  (Default)"
		fi
	else # Not found
		if [[ -n "$1" ]]; then
			echo "${PWD:A}:${1:A}" >> "$savedFile"
			echo "  Set file: $1"
		else
			local default="./main.py"
			echo "${PWD:A}:${default:A}" >> "$savedFile"
			echo "  Set file: ./main.py  (Default)"
		fi
	fi
}

[[ ! -f "$savedFile" ]] && echo "# You can manually add paths here." > "$savedFile"

setCommand
if [[ "${0##*/}" == "run" ]]; then
	if [[ -f "$file" ]]; then
		echo "$file"
		python3 "$file" "$@"
	else
		echo "run: no such file or directory: $file"
	fi
else # runfile
	save "$@"
fi
