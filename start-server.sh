#!/bin/bash
while true; do
  /tf2/srcds_run -game tf -norestart -nomaster +sv_pure ${SV_PURE:=1} +maxplayers ${MAXPLAYERS:=24} +hostname \"${G_HOSTNAME:="My TF2 Server"}\" "${ARGS}" +map ${MAP:=koth_nucleus}
done

