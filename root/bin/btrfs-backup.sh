#!/usr/bin/bash

# parse flags
# --storage-dir : directory to place incremental snapshots
# --no-dry-run : run backup ( defaults to dry run )
DRYRUN=true
SNAPSHOT_STORAGE=""
while test $# -gt 0; do
  case "$1" in
    --no-dry-run)
      DRYRUN=false
      shift
      ;;
    --storage-dir)
      shift
      SNAPSHOT_STORAGE=$1
      if [ $SNAPSHOT_STORAGE = "--no-dry-run" ] || [ $SNAPSHOT = "" ] ; then
        echo "\"--storage-dir\" flag specified, but not directory provided. Aborting."
        exit 1
      fi
      ;;
    *)
      shift
      ;;
  esac
done
echo -e "DRYRUN STATUS: $DRYRUN\n"

# check external drive
if [ -n "$SNAPSHOT_STORAGE" ] ; then
	echo "Taking snapshots and sending incremental snapshots to \"$SNAPSHOT_STORAGE\"."
else
	echo "No snapshot storage specified. Only taking snapshots. Not sending to storage."
fi
echo -e "\n"

# check for "btrfs" command
if [ ! -x "$(command -v btrfs)" ] ; then
	echo "Missing \"btrfs\" utils. Aborting."
	exit 1
fi

# subvolumes to snapshot
subvols=(
	"/"
	"/home"
	"/root"
	"/usr/local"
	"/opt"
	"/srv"
)

# snapshot locations (on root)
snapdirs=(
	"/.snapshots"
	"/home/.snapshots"
	"/root/.snapshots"
	"/usr/local/.snapshots"
	"/opt/.snapshots"
	"/srv/.snapshots"
)

# snapshot locations on external drive
destdirs=(
	"root"
	"home"
	"home_root"
	"usr_local"
	"opt"
	"srv"
)

# get previous timestamp from file
PREV_TIMESTAMP_FILE="/root/.btrfs-backup-prev-timestamp"
PREV_TIMESTAMP="$(< $PREV_TIMESTAMP_FILE)"

# get current timestamp for snapshots
TIMESTAMP="$(date +%Y%b%d_%H:%M:%S_%Z)"

# save timestamp to remember previous snapshot ( for incremental snapshots )
echo "OLD TIMESTAMP: $PREV_TIMESTAMP"
echo -e "NEW TIMESTAMP: $TIMESTAMP\n"
if [ -n "$SNAPSHOT_STORAGE" ] ; then
  echo -e "Storage specified. Updating timestamp."
  if [ $DRYRUN = true ] ; then
    echo "\"echo $TIMESTAMP > $PREV_TIMESTAMP_FILE\" (DRY RUN)"
  else
    echo "\"echo $TIMESTAMP > $PREV_TIMESTAMP_FILE\""
    echo "$TIMESTAMP" > "$PREV_TIMESTAMP_FILE"
  fi
else
  echo "No storage specified. Not updating timestamp."
fi
echo -e "\n"

# take snapshots
echo "Taking snapshots."
for i in "${!subvols[@]}" ; do
  if [ $DRYRUN = true ] ; then
    echo "\"btrfs subvolume snapshot -r ${subvols[$i]} ${snapdirs[$i]}/$TIMESTAMP\" (DRY RUN)"
  else
    echo "\"btrfs subvolume snapshot -r ${subvols[$i]} ${snapdirs[$i]}/$TIMESTAMP\""
    btrfs subvolume snapshot -r "${subvols[$i]}" "${snapdirs[$i]}/$TIMESTAMP"
  fi
done
echo -e "\n"

# send incremental snapshots to external device if specified
if [ -n "$SNAPSHOT_STORAGE" ] ; then
  echo "Sending incremental snapshots to $SNAPSHOT_STORAGE"
	for i in "${!subvols[@]}" ; do
    if [ $DRYRUN = true ] ; then
      echo "\"btrfs send -p ${snapdirs[$i]}/$PREV_TIMESTAMP ${snapdirs[$i]}/$TIMESTAMP | btrfs receive $SNAPSHOT_STORAGE/${destdirs[$i]}\" (DRY RUN)" 
    else
      echo "\"btrfs send -p ${snapdirs[$i]}/$PREV_TIMESTAMP ${snapdirs[$i]}/$TIMESTAMP | btrfs receive $SNAPSHOT_STORAGE/${destdirs[$i]}\"" 
      btrfs send -p "${snapdirs[$i]}/$PREV_TIMESTAMP" "${snapdirs[$i]}/$TIMESTAMP" | btrfs receive "$SNAPSHOT_STORAGE/${destdirs[$i]}"
    fi
	done
fi
echo -e "\n"

echo -e "FINISHED"
