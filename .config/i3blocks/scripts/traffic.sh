LENGTH=11
INFO="$(vnstat --iface wlp2s0 -tr 2 --json | sed 's/,/\n/g')"

lookuprx='"rx":{"ratestring":"'
RXVAL="$(echo "$INFO" | grep "$lookuprx")"
RXVAL="${RXVAL:${#lookuprx}}"
RXVAL="0000${RXVAL:0:$((${#RXVAL} - 1))}"
RXVAL="${RXVAL:$((${#RXVAL} - $LENGTH))}"

lookuptx='"tx":{"ratestring":"'
TXVAL="$(echo "$INFO" | grep "$lookuptx")"
TXVAL="${TXVAL:${#lookuptx}}"
TXVAL="0000${TXVAL:0:$((${#TXVAL} - 1))}"
TXVAL="${TXVAL:$((${#TXVAL} - $LENGTH))}"

echo "$RXVAL - $TXVAL"
