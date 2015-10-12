#!/usr/bin/perl -w
use strict;
use File::Find;

sub wanted {
	if { -f $File::Find::name } {
		if { $File::Find::name=~/\.tmp$/i } {
			print "Removing $File::Find::name";
			unlink $File::Find::name;
		}
	}

}
find \&wanted, '/root';
