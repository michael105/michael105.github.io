#!/usr/bin/perl


$nd=0;
$maindebug = 0;
$erstesattr = 0;

sub attribut(){
	#  $Attribut, @Array 
	my $attr = shift @_;
	my @attl = @_;
	$erstesattr = $attr if ( ! $erstesattr );
	push @attribute, $attr;
	@$werte{ $attr } = \@attl;
}


#sub build(){
#				for ( my $a = 0; $a<$nominatoren; $a++ ){
#								foreach ( @attribute ) {
#												@nominator[$a]->{$_ } = undef;
#								}
#				}
#}



# Prüft eval.
sub checkeval(){
	my $evalled = shift;
	my $error = shift;
	if ( $error ){
		print "$evalled\n$error\nAbbruch.\n";
		die();
	}
}

# Erstellt die Funktionen Name, Namex, ...
sub build(){				

	for ( my $a = 0; $a<$nominatoren; $a++ ){
		foreach my $attr ( @attribute ) {
			$nominator[$a]->{$attr } = "undef";
		}
	}

	my @variables = ( qw( x y z ) );
	for my $var ( @variables ) {

		# x(), y() und z() führen einen Test für jedes Element des Arrays durch, 
		# das die als erster Parameter übergebene Funktion als Referenz liefert.
		# Als zweiter Parameter muss der Ausdruck übergeben werden, der als Ergebnis true oder false liefert und
		# bei dem jedes Vorkommen von X, Y bzw. Z für jedes Elements des übergebenen Arrays geprüft wird.
		*$var = sub (){
			#print "x, start\n";
			$nd = 0;
			my $f = shift();
			#print "f: $f\n";
			my @arr = @{ eval ($f) };
			&checkeval( $f, $@ );	
			#print "arr: @arr \n";
			return 1 if ( $nd == 1 );
			#print "x: defined\n";
			my $ausdruck = shift;

			for my $y ( @arr ){
				my $ausdrucky = $ausdruck;
				$b = uc( $var );
				#print "b: $b\n";
				$ausdrucky =~ s/$b/$y/g;
				#print "x, eval: $ausdrucky\n";
				$nd = 0;
				my $bool = eval ($ausdrucky);
				&checkeval( $ausdrucky, $@ );
				#if ( $nd == 0 ) { print "x: defined 2\n";} else { print "x, nd2\n";}
				if ( ($nd==0) && !$bool ){
					#print "x, false\n";
					return 0;
				}
			}				

			#print "x, true\n";
			return 1;
		};
	}


	for my $attr ( @attribute ) {				
		no strict 'refs';
		# Erstelle die Attributsfunktionen,
		# nehmen als Parameter eine Funktion, die eine Referenz auf ein Array von Nominatoren liefert,
		# und geben die Attribute dieser Nominatoren ebenfalls als Referenz auf ein Array von Attributen zurück
		*$attr = sub {
			#print "$attr :  \n";
			my $arref = shift(@_);

			if ( $arref == undef ){
				#print "$attr nd \n";
				$nd = 1;
				return undef;
			}
			#print "@{$arref}[0]\n";

			my @rarr;
			for my $nom ( @{$arref} ) {
				if ( $nom->{$attr} eq "undef" ){
					$nd = 1;
					#print "$attr doch nd !\n";
				} else {
					push @rarr, $nom->{$attr};
					#print "$nom->{$attr}\n";
				}
			}
			return \@rarr;
		};

		for my $var ( @variables ){
			$attrx = "$attr" . $var;
			# "Attribut"x, -y, -z Kehren mit einer Referenz auf ein Array der Werte des Attributs zurück
			*$attrx = sub {
				return ( $werte->{$attr} );
			};

			# attributx, -y -z kehrt mit einer Referenz auf das Array der Attribute zurück
			my $s = "attribut" . $var;
			*$s = sub {
				return \@attribute;
			}
		}


		for my $wert ( @{$werte->{$attr}}) {

			# Erstelle die Wertefunktionen.
			# Diese nehmen keine Parameter und geben eine Referenz auf ein Array von Nominatoren zurück
			*$wert = sub {
				my @arr;
				#print "wert: $wert\n";
				foreach my $nom2 ( @nominator ) {
					if ( $nom2->{$attr} eq "undef" ){
						#								print "nom-> $attr nd\n";
						$nd = 1;
						return undef;
					}
					push @arr, $nom2 if ( $nom2->{$attr} eq $wert );
					#			print "wert: $wert\nnom->attr: $nom2->{attr}\n";
				}
				return \@arr;
			}
		}
	}
}


# Kehrt mit der Anzahl der Elemente zurück, die die als erster Parameter übergebene Funktion 
# als Referenz auf ein Array liefert
sub anzahl(){
	my @arr = @{shift(@_)};
	#print "anzahl, arr: @arr\n";
	if ( @arr == undef ){
		#print "Anzahl, Not defined\n";
		$nd = 1;
		return 0;
	}
	#print "Anzahl, def.\n";
	return scalar( @arr );
}


# Kehrt mit einem Element des als Referenz übergebenen Arrays zurück
sub e(){ return &element(@_);}
sub element(){
	#print "element\n";
	@arr = @{ shift() };
	if ( @arr == undef ) {
		$nd = 1;
		#print "e: undef\n";
		return undef;
	}
	#print "e: def\n";
	return $arr[0];
}


# Kehrt mit der Ordnungsnummer zurück.
# Parameter 1 : Die Attributsbezeichnung
# Parameter 2 : Der Wert
sub on(){ return &ordnungsnummer(@_); }
sub ordnungsnummer() {
	my $attr = shift;
	my $w = shift;
	#print "w: $w\n";
	if ( $w eq "" ){
		$nd = 1;
		return( 0 );
	}
	#print "$attr    ..   $w\n";

	for ( my $a = 0; $a < scalar( @{$werte->{$attr}} ); $a++ ){
		return $a if ( @{$werte->{$attr}}[$a] eq $w );
	}
	print "Error in ordnungsnummer, $w not found !\n";
	return 0;
}



# prüft den als ersten Parameter übergebenen Ausdruck, der true oder false liefern muss
sub pruefe(){
	$nd = 0;
	$f = shift;
	#&ausgabe();
	#print "f: $f\n" if ( $maindebug );
	my $bool = eval( $f );
	&checkeval( $f, $@ );
	return 1 if ( $nd == 1 );
	#&ausgabe();
	#print "pr: Defined\n";
	if ( $maindebug ) {
		print "geprüft: $f   -   ";
		if ( $bool ){
			print "Ok.\n";
		} else { 
			print "Falsch.\n";
		}
	}
	return $bool;
}


# Gibt die Werte der Nominatoren aus
sub ausgabe(){
	foreach my $nom ( @nominator ){
		foreach my $attr ( @attribute ){
			print "$attr: $nom->{$attr}   ";
		}
		print "\n";
	}
}


sub iteriere(){
	my $n_zeiger = shift;
	my $a_zeiger = shift;
	#print "Iter start\n";

	#&ausgabe();
	$n_zeiger ++;
	if ( $n_zeiger == $nominatoren ) {
		$a_zeiger ++;

		if ( $a_zeiger == scalar(@attribute) ){
			print "Lösung: \n";
			$maindebug = 1;
			&test();
			$maindebug = 0;
			print "\n";
			&ausgabe();
		} else {
			$n_zeiger = 0;
			#&iteriere( $n_zeiger, $a_zeiger );
		}
	}

	foreach $w ( @{ $werte->{ $attribute[$a_zeiger] } } ){
		#push ( Falls mehrere Werte auf einmal möglich sind, dann jedoch auch hier eine rekursion
		#print "iter, w: $w\n","attr: $attribute[$a_zeiger]\n", "$nominator[$n_zeiger]->{$attribute[$a_zeiger]} \n";
		$nominator[$n_zeiger]->{$attribute[$a_zeiger]} = $w;
		#&ausgabe();
		if ( &test() ){
			#print "iter, test Ok.\n";
			&iteriere( $n_zeiger, $a_zeiger );
		} else {
			#print "iter, test not ok.\n";
		}
		#print "iter, foreach bottom\n";
	}
	# Die Reihenfolge des ersten Attributes spielt keine Rolle
	if ( $a_zeiger == 0 ){
		exit( 0 );
	}
	#print "iter, nach foreach\n";
	$nominator[$n_zeiger]->{$attribute[$a_zeiger]} = "undef";

}


sub test(){
	return 0 if ( &struktur() != 1 );
	#print "S Ok.\n";
	return 0 if ( &hinweise() != 1 );
	#print "H Ok.\n";
	#print "test Ok.\n";
	return 1;
}





sub startup(){
	#1				$nominatoren=2;
	#1				&attribut( "Name", qw( Anna Katrin ) );
	#1				&attribut( "Nachname", qw( Fischer Mueller ) );
	#1				&attribut( "Betrag", ( 2, 5 ) );

	#2					$nominatoren = 4;
	#2					&attribut( "Tag", qw( Montag Dienstag Mittwoch Donnerstag ) );
	#2					&attribut( "Beamter1", qw( Arafth Denkl Moehler Querig ) );
	#2					&attribut( "Beamter2", qw( Bresda Gerlach Roesner Zotart ) );
	#2					&attribut( "Code", (1,2,3,4));

	#3					$nominatoren = 5;
	#3					&attribut( "Tag", qw( Montag Dienstag Mittwoch Donnerstag Freitag) );
	#3					&attribut( "Fleisch", qw( Gulasch Hackbraten Schnitzel Schweinebraten Steak ) );
	#3					&attribut( "Beilage", qw( Bratkartoffeln Knoedel Nudeln Pommes Reis ) );
	#3					&attribut( "Salat", qw( Endivien Feld Gurken Kopf Tomaten ) );

	$nominatoren = 5;
	&attribut( "Vorname", qw( Bertram Horst Jupp Moritz Wolfgang ) );
	&attribut( "Nachname", qw( Jochim Kelde Lundt Reiter Schmitt ) );
	&attribut( "Startnummer", ( 2,4,7,8,11 ) );
	&attribut( "Platz", qw( Erster Zweiter Dritter Vierter Fuenfter ) );
}



# Hier muss die Überprüfung der grundlegenden Struktur der logischen Verknüpfungen stattfinden
sub struktur(){
	#1				return 0 if ( ! &x( "Namex()", '&anzahl(X) == 1' ) );
	#1				return 0 if ( ! &x( "Nachnamex()", '&anzahl(X) == 1' ) );
	#1				return 0 if ( ! &x( "Betragx()", '&anzahl(X) == 1' ) );

	#print "Struktur Ok.\n";


	#				return 0 if ( ! &x( "Tagx()", '&anzahl(&X) == 1' ) );
	#				return 0 if ( ! &x( "Beamter1x()", '&anzahl(&X) == 1' ) );
	#				return 0 if ( ! &x( "Beamter2x()", '&anzahl(&X) == 1' ) );
	#				return 0 if ( ! &x( "Codex()", '&anzahl(&X) == 1' ) );

	# Der Wert von jedem Attribut darf nur einmal vorkommen
	return 0 if ( ! &x( "attributx()", '&y( "Xx()", \'&anzahl(&Y) == 1\' )' ) );




	return 1;

}


# Hier werden die Hinweise eingegeben
sub hinweise(){

	# 1				return 0 if ( &pruefe('&element( Betrag( Anna ) ) > &element( Betrag( Fischer ) )') != 1 );
	#				return 0 if ( &pruefe( '( &element( &Nachname( &Anna() ) ) ne "Mueller" )' ) != 1 );


	#2				return 0 if ( ! &pruefe( '&e( &Tag( &Denkl )) eq "Dienstag"' ) );
	#2				return 0 if ( &pruefe( '&e( &Code( &Arafth ) ) - 1 == &element( &Code( &Roesner ) )' ) != 1 );
	#2				return 0 if ( &pruefe( '&ordnungsnummer( "Tag", &element( &Tag( Bresda ) ) ) -1 == 
	#2						&ordnungsnummer( "Tag", &element( &Tag( Moehler ) ) )' ) != 1 );
	#2				return 0 if ( &pruefe( '&element( &Code( Bresda ) ) == 3' ) != 1 );
	#2				return 0 if ( &pruefe( '&element( &Code( Moehler ) ) != 1') != 1 );
	#2				return 0 if ( &pruefe( '&element( &Tag( Querig ) ) ne "Donnerstag"') != 1 );
	#2				return 0 if ( &pruefe( '(&element( &Code( Querig ) ) == 3 ) || ( &element( Code( Querig ) ) == 4 )' ) != 1 );
	#2				return 0 if ( &pruefe( '&element( Beamter2( Querig ) ) ne "Zotart"' ) != 1 );


	#3				return 0 if ( ! &pruefe( '"Donnerstag" eq &e( &Tag( &Schnitzel() ) )' ) );
	#3				return 0 if ( ! &pruefe( '("Donnerstag" eq &e( &Tag( &Bratkartoffeln() ) ))' ) );
	#3				return 0 if ( ! &pruefe( '( ((&ordnungsnummer( "Tag", &e( &Tag( &Endivien() ) ) ) + 2) == (&ordnungsnummer( "Tag", &e( &Tag( &Feld() ) ) ) +1)) && ( (&ordnungsnummer( "Tag", &e( &Tag( &Endivien() ) ) ) + 2) == (&ordnungsnummer( "Tag", &e( &Tag( &Gurken() ) ) ) ) ) ) || ( ( (&ordnungsnummer( "Tag", &e( &Tag( &Endivien() ) ) ) - 2) == (&ordnungsnummer( "Tag", &e( &Tag( &Feld() ) ) ) -1) ) && (  (&ordnungsnummer( "Tag", &e( &Tag( &Endivien() ) ) ) - 2) == (&ordnungsnummer( "Tag", &e( &Tag( &Gurken() ) ) ) ) ) )' ) );
	#3				return 0 if ( ! &pruefe( '&e( Salat( Dienstag ) ) eq "Kopf"' ) );
	#3				return 0 if ( ! &pruefe( '&e( Fleisch( Dienstag ) ) ne "Gulasch"' ) );
	#3				return 0 if ( ! &pruefe( '&e( Fleisch( Dienstag ) ) ne "Hackbraten"' ) );
	#3				return 0 if ( ! &pruefe( '( ( ( &e( Fleisch( Montag ) ) eq "Gulasch" ) && ( &e( Beilage( Mittwoch ) ) eq "Knoedel" ) && ( &e( &Salat( &Mittwoch ) ) eq "Endivien" ) ) && ! ( ( &e( Beilage( Montag ) ) eq "Reis" ) || ( &e( Beilage( Freitag ) ) eq "Knoedel" ) || ( &e( Salat( Freitag ) ) eq "Endivien" ) ) ) || ( ( ( &e( Beilage( Montag ) ) eq "Reis" ) && ( &e( Beilage( Freitag ) ) eq "Knoedel" ) && ( &e( Salat( Freitag ) ) eq "Endivien" ) ) && ! ( ( &e( Fleisch( Montag ) ) eq "Gulasch" ) || ( &e( Beilage( Mittwoch ) ) eq "Knoedel" ) || ( &e( &Salat( &Mittwoch ) ) eq "Endivien" ) ) )' ) );
	#3				return 0 if ( ! &pruefe( '&e( Fleisch( Freitag ) ) eq "Schweinebraten"' ) );
	#3				return 0 if ( ! &pruefe( '&e( Salat( Nudeln  ) ) ne "Tomaten"' ) );
	#3				return 0 if ( ! &pruefe( '&e( Beilage( Gulasch )) ne "Pommes"' ) );


	return 0 if ( !&pruefe( '&e( Nachname( Bertram ) ) eq "Jochim"' ));
	return 0 if ( !&pruefe( '&e( &Platz( &2() )) eq "Zweiter"' ) );
	return 0 if ( !&pruefe( '&e( &Startnummer( &Wolfgang ) ) == 8' ));
	return 0 if ( !&pruefe( '&e( &Nachname( &Wolfgang ) ) lt "M"' ));
	return 0 if ( !&pruefe( '&on("Platz", &e( &Platz( &Moritz ) )) -2 >= &on( "Platz", &e( &Platz( &Lundt ) ) )' ));
	return 0 if ( !&pruefe( '&e( Platz( Kelde ) ) eq "Vierter"' ));
	return 0 if ( !&pruefe( '&e( Startnummer( Kelde )) < 8' ));
	return 0 if ( !&pruefe( '&e( Nachname( Jupp ) ) ne "Schmitt"' ));
	return 0 if ( !&pruefe( '&e( Startnummer( Jupp ) ) != 11' ));
	return 0 if ( !&pruefe( '&e( Platz( Jupp ) ) eq "Erster"' ));
	#return 0 if ( !&pruefe( '&e( Startnummer( Schmitt ) ) != 11' ));
	return 0 if ( !&pruefe( '&e( Startnummer( Horst ) ) != 7' ));

	return 1;
}







# MAIN

&startup();

&build();


for( my $a = 0; $a < scalar( @{$werte->{$erstesattr}} ); $a++){
	$nominator[$a]->{$erstesattr} = @{$werte->{$erstesattr}}[$a];
}




# Nur -1,1 wenn das erste Attribut feststeht. sonst -1,0				
&iteriere(-1,1);












