#!/usr/bin/perl

$list_cmd = "/sbin/zfs get -r -o name,value -t filesystem refquota vol";

open(MF,"$list_cmd |");
while(<MF>) {
  $list=$_;
  chomp($list);
  if($list =~ /^vol/) {
    @filter = split(/\s+/,$list);
    $folder = $filter[0];
    $quota = $filter[1];
    if($quota eq "none") {
      next;
    } else {
      print "$folder refquota=$quota\n";
      &set_quota($folder,$quota);
    }
  } else {next;}

}
close(MF);


sub set_quota {
  my($folder,$quota) = @_ ;
  $zfs_set = "/sbin/zfs set refquota=none";
  $zfs_get = "/sbin/zfs get refquota";
  $check_quota = "/sbin/zfs get -r -o value -t filesystem refquota $folder |tail -1";

  print "Setting $folder refquota=none.....";
  #print "$zfs_set $folder\n";
  print `$zfs_set $folder`;
  sleep 5;
  $now_refquota = `$check_quota`;
  sleep 5;
  chomp($now_refquota);
  if($now_refquota eq "none"){print "OK\n";}else{print "Fail\n";print ">>>>>$folder refquota=$now_refquota\n";}
}
