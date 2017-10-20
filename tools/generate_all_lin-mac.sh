#!/bin/sh

FINALLUA="../3rdLuaFmw.lua"
echo "-- 3rd DCS Lua Framework" >> $FINALLUA
for f in `ls ../modules/*/*.lua`
do
  echo "Integrate $f..."
  cat $f >> $FINALLUA
done
