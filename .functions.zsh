# User defined functions
# ----------------------
function proxy() {
  export ALL_PROXY=http://localhost:1087
  export HTTP_PROXY=http://localhost:1087
  export HTTPS_PROXY=http://localhost:1087
}
function noproxy() {
  unset ALL_PROXY
  unset HTTP_PROXY
  unset HTTPS_PROXY
}
# proxy  # default: set proxy!

if (( ${+IPINFO_API_TOKEN} )); then
  function ipinfo() {
    curl "ipinfo.io/${1}?token=${IPINFO_API_TOKEN}"
  }
  function domainip() {
    DNSTOOL=dig
    # (( ! ${+commands[drill]} )) || DNSTOOL=drill
    IP=$($DNSTOOL +short ${1})
    echo ${1} 'resolved to' ${IP}
    IP=$(echo -n $IP | grep -m1 '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')
    curl "ipinfo.io/${IP}?token=${IPINFO_API_TOKEN}"
  }
fi

function ipp() {
  curl "ip.trickysky.com/${1}"
}
