#!/bin/sh
{
    IP=$(dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com | tr -d \")
    if [ "$IP" ]; then
        for DOMAIN_NAME in ${DYNHOST_DOMAIN_NAMES}; do
            CURRENT_IP=$(dig +short $DOMAIN_NAME)
            if [ "$CURRENT_IP" != "$IP" ]; then
                    echo "Updating $DOMAIN_NAME from $CURRENT_IP to $IP"
                    curl -s --user "${DYNHOST_LOGIN}:${DYNHOST_PASSWORD}" \
                        "https://www.ovh.com/nic/update?system=dyndns&hostname=${DOMAIN_NAME}&myip=${IP}" \
                        | grep --color=never "title" >&2
            fi
        done
    else
        >&2 echo "IP not found"
    fi
} >>$STDOUT 2>>$STDERR
