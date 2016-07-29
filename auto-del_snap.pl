#!/usr/bin/perl

$path=`pwd`;
chomp($path);
my $logfile = "$path/snap.log";
#print "$logfile \n";
if (-e $logfile) {
  print "Start destroy snapshot \n";
 }
else {
  print "Error : Can not find $logfile \n";
  exit;
}
open(MF,"$logfile");
while(<MF>) {
  chomp;
  if ( $_ =~ /@/ ) {
    #print "snapshot:$_ will destroy \n";
    #$del="zfs destroy -v $_";
    $creation="zfs get creation $_";

    ##destroy snapshot
    #print `$del`;
    print `$creation`;

    sleep 3;
  }
  else {
  print "$_ is not snapshot\n";
  }
}
close(MF);
