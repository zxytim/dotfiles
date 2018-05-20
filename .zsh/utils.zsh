
get_os_distribution() {
	awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }'
}

OS_DISTRIBUTION=$(get_os_distribution)


safe_source() {
	[ -s "$1" ] && source "$1"
}

version_compare_less_equal() {
    [ "$(echo "$1\n$2" | sort -V | head -n 1)" = "$1" ]
}

version_compare_greater_equal() {
    [ "$(echo "$1\n$2" | sort -V | head -n 1)" = "$2" ]
}
