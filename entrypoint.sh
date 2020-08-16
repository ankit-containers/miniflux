#!/bin/sh

cat > /etc/miniflux.conf << EOF

LISTEN_ADDR=$LISTEN_ADDR
DATABASE_URL=user=$POSTGRES_USER password=$POSTGRES_PASSWORD dbname=$POSTGRES_DB host=$POSTGRES_HOST sslmode=disable
EOF

/usr/local/bin/miniflux -c /etc/miniflux.conf
