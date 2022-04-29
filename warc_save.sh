#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function warc_save_main () {
  export LANG{,UAGE}=en_US.UTF-8  # make error messages search engine-friendly
  local SELFPATH="$(readlink -m -- "$BASH_SOURCE"/..)"
  cd -- "$SELFPATH" || return $?
  mkdir --parents -- cache

  local LOG_FILE='cache/archiver.log'
  local CITIES=()
  local REPORT_TYPES=(
    ''
    /{,ueber}morgen
    /tag-{3,4}
    /unwetterwarnung
    /{14,30}-tage
    )

  source -- config.rc --config || return $?$(
    echo "E: Failed to read config, rv=$?" >&2)
  [ -z "$LOG_FILE" ] || exec &>"$LOG_FILE" || return $?

  printf '%(%F)T start\n' -1
  local CITY= DAY=
  for CITY in "${CITIES[@]}"; do
    for DAY in "${REPORT_TYPES[@]}"; do
      warc_save_one_page www "wetter$DAY/$CITY.html"
    done
  done

  local CSS_VER=
  for CSS_VER in {014..016}; do
    warc_save_one_page static common/styles"$CSS_VER".css
  done

  printf '%(%F)T done\n' -1
  return 0
}


function warc_save_one_page () {
  local SUB="$1"; shift
  local URL="$1"; shift
  local SAVE="$URL"
  SAVE="${SAVE#/}"
  SAVE="${SAVE//\//_}"
  SAVE="$SUB.${SAVE:-_}"
  URL="http://$SUB.donnerwetter.de/$URL"
  URL="http://web.archive.org/save/$URL"
  SAVE="cache/$SAVE"
  >"$SAVE"
  local WGET_OPTS=(
    --output-document="$SAVE"
    --save-headers
    # --quiet
    --tries=1
    --timeout=30
    )
  wget "${WGET_OPTS[@]}" "$URL" || return $?
  tty --silent || sleep 5s
  return 0
}










warc_save_main "$@"; exit $?
