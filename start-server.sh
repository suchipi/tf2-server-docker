#!/bin/bash
while true; do
  /tf2/srcds_run -game tf -norestart +sv_pure ${SV_PURE} +maxplayers ${MAXPLAYERS} +hostname "${G_HOSTNAME}" "${ARGS}" -port ${PORT} +map ${MAP}
done

