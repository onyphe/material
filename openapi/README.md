# ONYPHE API: OpenAPI specification

An OpenAPI 3.0.3 description of four ONYPHE API endpoints:

- **Search**: paged OQL (ONYPHE Query Language) search, up to 10,000 results.
- **Export**: a complete population, streamed as NDJSON.
- **Discovery**: bulk OQL over an asset inventory.
- **ASD Pivot Query**: the distinct values of a field across a query
  (Attack Surface Discovery).

The full ONYPHE documentation is at https://search.onyphe.io/docs.

## Contents

- `onyphe-openapi.yaml`: the OpenAPI 3.0.3 spec.
- `index.html`: a Swagger UI viewer, loading swagger-ui-dist 5.17.14 from unpkg.
- `redocly.yaml`: lint configuration for `@redocly/cli`.
- `LICENSE`: BSD 3-Clause.

## View

Open `onyphe-openapi.yaml` in any OpenAPI viewer, or serve this directory
locally:

    python3 -m http.server --bind 127.0.0.1 8000
    # then open http://127.0.0.1:8000/

To lint the spec:

    npx @redocly/cli lint onyphe-openapi.yaml

## Which category, which data model

| Use case | Categories | Data model | Entry points |
|---|---|---|---|
| IP enrichment, CTI, hunting | `ctiscan`, `ctiurl` | ctiscan (`ip.dest`, `tcp.dest`, `app.data.text`, `component.*`) | Search, Export, ASD Pivot Query |
| ASM | `riskscan`, `vulnscan` | datascan (`ip`, `port`, `tag`, `cve`, `data`) | Discovery, Search, Export |

A field from the wrong data model returns 0 results, not an error. The spec
description has the full field-translation table.

## Authentication

- v2 API (Search, Export, Discovery): `Authorization: Bearer <key>` against
  `https://www.onyphe.io/api/v2`.
- ASD v1 API: the same key in `X-Api-Key` against
  `https://www.onyphe.io/api/v1`.

The curl samples in the spec read the key from `$ONYPHE_API_KEY`. Keep the key
in an environment variable or a local config file, and never commit it.

## Using the ONYPHE CLI

The spec documents the HTTP API only. The `onyphe` CLI wraps the same
endpoints:

    onyphe -search 'category:ctiscan ip.dest:192.0.2.10 -fields:ip.dest,tcp.dest,app.protocol,tag'
    onyphe -export 'category:ctiscan component.cpe:"cpe:/a:apache:http_server:-" -dayago:1 -fields:ip.dest,tcp.dest,component.version,tag'
    onyphe -discovery riskscan 'inventory.txt -since:3M -fields:ip,port,hostname,tag,seen_date'
    onyphe -asd-pivot-query 'category:ctiscan app.device:c2 -dayago:1' -field cert.issuer.cn

The CLI behaves differently from raw HTTP in two ways:

- **Credentials**: the CLI reads `api_endpoint` and `api_key` from
  `~/.onyphe.ini`. ASD also needs
  `api_asd_endpoint = https://www.onyphe.io/api/v1`, with the same key.
- **Discovery**: the CLI takes an inventory file, appends the trailing options
  to every line, and drops blank lines and `#` comments before sending.

## Licence

BSD 3-Clause. See `LICENSE`.
