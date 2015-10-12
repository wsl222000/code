#!/usr/bin/perl -w
use strict;
use File::Find;

sub wanted {
	if ($_ eq "lrsync.lua") {
		print $File::Find::name, "\n";
	}
}
find \&wanted, '/usr/local/etc';
