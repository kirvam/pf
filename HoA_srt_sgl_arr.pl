use strict;
use warnings;
use Data::Dumper;
use Sort::Naturally;

my($HoAref) = while_();
# my $HoAref = \%HoA;
print "Dumper \$HoAref\n";
print Dumper \$HoAref;

print_Href($HoAref);
print_Href_csv($HoAref);


sub print_Href{
my($HoAref) = @_;
  foreach my $tkey ( sort keys %{ $HoAref } ){
       print "\$tkey: $tkey: \n";
          foreach my $key ( sort keys %{ $HoAref->{$tkey} } ){
                print "\$key: $key: \n";
               my @AoA = @{ ${$HoAref}{$tkey}{$key} };
                 foreach my $i ( 0 .. $#AoA ){
                      foreach my $j ( 0 .. $#{ $AoA[$i] } ) {
                         print "\t[$i][$j]: $AoA[$i][$j]\n";
                      }
                   } 
                  }
                 }  
};

sub print_Href_csv{
my($HoAref) = @_;
my $ii;
my $line;
my $header;
  foreach my $tkey ( nsort keys %{ $HoAref } ){
       #print "\$tkey: $tkey: \n";
         # $line .= "$tkey,";
         my $file = $tkey.".csv";
         open( my $fh, ">", $file ) || die "Flaming death on open of $file:$! \n";
          print "File $file opened!\n";
           $ii = ();
          foreach my $key ( nsort keys %{ $HoAref->{$tkey} } ){
                #print "\$key: $key: \n";
                # $line .= "$key,";
               my @AoA = @{ ${$HoAref}{$tkey}{$key} };
                 #my $header = "$tkey,$key,";
                 my $header = "$tkey,";

                 foreach my $i ( 0 .. $#AoA ){
                      $line = ();
                      foreach my $j ( 0 .. $#{ $AoA[$i] } ) {
                         #print "$AoA[$i][$j],";
                         $line .= "$AoA[$i][$j],";
                      }
                     $line = $header.$line;
                     $ii++;
                     print "$ii,$line\n";
                     print $fh "$ii,$line\n";
                     
                   } 
                     #print "\$line: $line\n";
                     #$line = ();
                  }  
                 }  
};


sub while_{
my %HoA =();
while(<DATA>){
 my $line = $_;
 chomp($line);
 my @array = split(/,,*/,$line);
  print "Number items in array: $#array:  ";
   my $key = $array[0];
   my $date = $array[1];
   push @{ $HoA{$key}{$date} }, [ @array ];
    foreach my $item ( 0 .. $#array ){
        print "$array[$item], ";
      }
    print "\n";
  };
 return(\%HoA);
};

__DATA__
cat,1/9/2019,tiger,stripes,wild
cat,1/2/2019,house cat,black,domestic
cat,1/2/2019,tabby cat,tan,domestic
cat,1/2/2019,yellow cat,tan,domestic
fish,1/22/2019,perch,brown,wild
fish,1/3/2019,trout,rainbow,wild
fish,1/7/2019,gold fish,gold,doemstic
dog,1/2/2019,german shepherd,black,domestic
dog,1/3/2019,wolf,gray,wild
dog,1/4/2019,wolf,gray,wild
dog,1/4/2019,wolf,white,wild
dog,1/4/2019,wolf,silver,wild
dog,1/4/2019,wolf,black,wild
dog,1/4/2019,wolf,brownr,wild

