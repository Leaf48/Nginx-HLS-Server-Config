#!/bin/bash

# Find the latest .m3u8 file in /tmp/hls/
LATEST_M3U8=$(ls -t /tmp/hls/*.m3u8 2>/dev/null | head -n 1)

# Check if the file exists and is not already a symlink to itself
if [ -n "$LATEST_M3U8" ] && [ "$LATEST_M3U8" != "/tmp/hls/stream.m3u8" ]; then
    # Remove the old symlink if it exists
    rm -f /tmp/hls/stream.m3u8

    # Create a new symlink
    ln -sf "$LATEST_M3U8" /tmp/hls/stream.m3u8
    echo "Symlink created for $LATEST_M3U8"
else
    echo "No .m3u8 file found or symlink already exists."
fi

