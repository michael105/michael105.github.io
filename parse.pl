#!/bin/perl -w
#
#


# Those both input files can be found (after make, make header) in:
# linux-src/usr/include/asm/unistd_64.h
# linux-src/include/linux/syscalls.h

my $syscalls="syscalls.h";
my $unistd="unistd_x64.h";

my $out = "syscalls.html";


use Data::Dumper::Simple;


open $s,"<",$syscalls or die;
open $u,"<",$unistd or die;



my %scalls;
my @sortedcalls;


foreach my $l ( <$u> ){
	if ( $l =~ /^#define __NR_(\S*)\s*(\d*)/ ){
		print "$1  =  $2\n";
		$scalls{$1}->{N} = $2;
		push @sortedcalls, $1;
	}
}


print Dumper(%scalls);


my @sys;
while ( my $l = <$s> ){
	while ( $l =~ /^asmlinkage long sys_(\w*)(.*)\n/ ){
		#print "$1: $l";
		my $n = $2;
		my $name = $1;
		while ( ($l = <$s>) && ( $l=~/^\s\s*(.*)\n/ ) ){
				$n.=$1;
		}
		print "N: $name: $n\n";
		$n =~ s/^\W*(.*)\);/$1/;
		$n =~ s/__user//g;
		$n =~ s/__kernel_old_//g;
		$n =~ s/__old_kernel_//g;
		$n =~ s/__kernel_//g;
		$n =~ s/unsigned /u/g;
		$scalls{$name}->{args} = $n;

	}
}

print Dumper(%scalls);

my %parsed;

open O,">",$out;

print O "<html>\n<body>\n<h3>Linux syscall table amd64 6.3</h3>\n";
print O "<table>\n";
my $sw = 1;

foreach my $c ( @sortedcalls ){
	print "$c : $scalls{$c}->{N} : $scalls{$c}->{args}\n";
	if ( $sw ){
		print O "<tr bgcolor=\"lightgrey\"><td>$scalls{$c}->{N}</td><td>$c</td><td>";
		$sw = 0;
	} else {
		print O "<tr><td>$scalls{$c}->{N}</td><td>$c</td><td>";
		$sw = 1;
	}
	$c = "mmap_pgoff"	if ( $c =~ /^mmap/ );
	$c = "newfstatat"	if ( $c =~ /^fstatat/ );

	
	if ( !defined($scalls{$c}->{args}) ){
		print O "?";
	} else {
		print O join("</td><td>", split( ",", $scalls{$c}->{args} ) );
	}
	print O "</td></tr>\n";

}

print O "</table>\n</body></html>\n";



