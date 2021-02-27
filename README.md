# Miniflux

[![Registry](https://img.shields.io/badge/registry-quay.io-red)](https://quay.io/repository/ankitrgadiya/miniflux?tab=tags)

Miniflux is an open-source minimalist Feed Reader written in Go. It is simple to
use, and it integrates with third-party services like Pinboard, Instapaper, and
Pocket. It is also a Progressive Web App so you can install it on the phone as a
native application. The developers of Miniflux offer hosted service at
[miniflux.app](https://miniflux.app) for $15/year.

Miniflux project ships a statically compiled binary for Linux, FreeBSD, OpenBSD,
and Mac OS. You can directly install the binary on a server and run it using
SystemD (or similar init systems). Miniflux also releases packages for
Debian-based and RPM-based distributions.

This repository packages the Miniflux binary in a Docker image to run it in the
container.

## Usage

Miniflux is a stateless application and uses a Postgres database to store the
data. Start the PostgreSQL database in a separate container or use a remote
database. Create a new database for Miniflux to use. Miniflux requires the
`hstore` extension to be enabled.

```sql
CREATE EXTENSION hstore
```

Create the Miniflux container, and pass database credentials as environment
variables. The PostgreSQL variables are used by Docker image to generate
`DATABASE_URL` for Miniflux. The image supports all the configuration variables
described [here](https://miniflux.app/docs/configuration.html).

```bash
docker run -d \
	--name "miniflux" \
	-e POSTGRES_HOST="127.0.0.1" \
	-e POSTGRES_DB="miniflux" \
	-e POSTGRES_USER="miniflux" \
	-e POSTGRES_PASSWORD="password" \
	-e LISTEN_ADDR="0.0.0.0:8080" \
	-p 8080:8080 \
	quay.io/ankitrgadiya/miniflux:latest
```

**TIP**: Set `RUN_MIGRATIONS` environment variable to automatically run database
migrations.

Once the Miniflux server is running, create the admin user by executing in the
container.

```bash
docker exec -it miniflux miniflux -create-admin
```

## Releases

Miniflux project follows semantic versioning. So, the image tags will correspond
to the upstream release versions. The `latest` tag will always point to the most
recent release. I intend to provide all versions from "2.0.26" onwards.
