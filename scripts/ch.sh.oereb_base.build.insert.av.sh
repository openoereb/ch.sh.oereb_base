#!/bin/bash

ili2pg_executable=$(find /tmp/ili2pg -iname 'ili2pg*.jar')
model="DM01AVCH24LV95D"
topics="DM01AVCH24LV95D.Liegenschaften;DM01AVCH24LV95D.Gemeindegrenzen;DM01AVCH24LV95D.Gebaeudeadressen"

for f in ./*.itf; do
  java -jar "$ili2pg_executable" \
    --import \
    --dbdatabase "$POSTGRES_DB" \
    --dbusr gretl \
    --dbport 54321 \
    --dbhost localhost \
    --dbpwd "$PG_GRETL_PWD" \
    --dbschema "$SCHEMA" \
    --models "$model" \
    --topics "$topics" \
    --disableValidation "$f"
done
