#!/bin/awk -f
BEGIN { delete ARGV }
{
  nc+=length($0)+1
  nw+=NF
}
END {print NR,nw,nc}
