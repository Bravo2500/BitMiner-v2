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
foreach(glob "C:\\Users\\$username\\AppData\\Roaming\\Microsoft\\Windows\\\"Start Menu\"\\Programs\\Startup\\*"){
  if($_ =~ /\.exe$/){
    print "Deseja remover $_ ? ";
    my $yes_or_no = <STDIN>;
    if($yes_or_no =~ /yes|sim|y|s|yep/i){
      unlink "$_";
    }
  }
}
