#!/usr/bin/perl
use warnings;
use strict;
$SIG{INT} = 'IGNORE';

my $username = `whoami`;
$username =~ s/(.*?)\\(.*?)//g;
foreach(glob "C:\\Users\\$username\\AppData\\Roaming\\*"){
  if($_ =~ /^Ns/ && $_ =~ /CPU|GPU/i && $_ =~ /\.exe$/){
    unlink "$_";
  }
  if($_ =~ /Data.bin/i){
    unlink "$_";
  }
}
