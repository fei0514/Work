#!/usr/bin/perl

$list_cmd = "/sbin/zfs get -r -H -o name,value -t filesystem compression vol";

open(MF,"$list_cmd |");
while(<MF>) {
  $list=$_;
  chomp($list);
  if($list =~ /^vol/) {
    @filter = split(/\s+/,$list);
    $folder = $filter[0];
    $compression = $filter[1];
    if($compression eq "lz4") {
      next;
    } else {
      print "$folder compression=$compression\n";
      &set_compression($folder,$compression);
    }
  } else {next;}
  
}
close(MF);


sub set_compression {
  my($folder,$compression) = @_ ;
  $zfs_set = "/sbin/zfs inherit compression";
  $check_compression = "/sbin/zfs get -o value -t filesystem compression $folder |tail -1";

  print "Setting $folder compression=inherit.....";
  #print "$zfs_set $folder\n";
  print `$zfs_set $folder`;
  sleep 5;
  $now_compression = `$check_compression`;
  sleep 5;
  chomp($now_compression);
  if($now_compression eq "lz4"){print "OK\n";}else{print "Fail\n";print ">>>>>$folder compression=$now_compression\n";}
}
