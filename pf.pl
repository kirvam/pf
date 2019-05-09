use strict;
use warnings;
use Data::Dumper;

my $file = shift;
chomp($file);
my $fname = shift;
print "\n---< $0 >---\n";
my($refHoA,$header_aref) = proc_file($file,'vm','tag');

print Dumper \$refHoA;
sub find_name {
my($vm,$tag) = @_;
if($vm =~ m/(^
           abc|
           def|
           hij|
           klmn
           )/ixg
                ){
      print "Found match: $1\n";
      my $val = $1;
      return($val);
   } elsif (
      $tag =~ m/(^
                 abc|
                 def|
                 hij|
                klmn
                 )/ixg
                   ){ 
                     print "Found match: $1\n";
                     my $val = $1;
                     return($val);
  } else {
    return($vm);
   };
}; 


sub proc_file {
my($file,$key_num,$key_note) = @_;
my $ii;
my %HoA;
my %map;
my @header;
open ( my $fh, "<", $file ) || die "Flaming death on open of $file: $!\n";
while(<$fh>){
  $ii++;
  my $line = $_;
  chomp($line);
  $line =~ s/\s*//;
  if( $ii eq 1 ){
    @header = split(/,/,$line);
    foreach my $kk ( 0 .. $#header ){
            $map{$header[$kk]} = $kk;
          };
    my $fnum = $#header + 1;
    print "$ii,line has $fnum fields.\n";
    $HoA{header} = $line;
        } else {
           my @line = split(/,/,$line);
           my $fnum = $#line + 1;
           print "$ii,line has $fnum fields.\n";
           my $knum = $map{$key_num};
           my $knote = $map{$key_note};
           my $val = $line[$knum];
           my $note = $line[$knote];
           #
           my $val = find_name($val,$note);
           #
           push @{ $HoA{$val} }, [ $line ];
  };     
 };
 print "\nHeader:\n";
  foreach my $item ( 0 .. $#header ){
           my $val = $item + 1;
           print "$header[$item] [$item + 1 = $val]\n";
   }
  print "\n";
  print "Total lines: $ii.\n";
 return(\%HoA,\@header);
}
