#!/usr/bin/env bash

find / -iname "*.so" \
       -user vntjofd \
       -type f       \
       -size +1M     \
       -exec ls {}   \;