package IO::Lcdproc::Screen;

use 5.008001;
use strict;
use warnings;
use Carp;

our $VERSION = '0.01';

sub new {
	my $proto			= shift;
	my $class			= ref($proto) || $proto;
	my %params			= @_;
	croak "No name for Screen: $!" unless($params{name});
	my $self			= {};
	$self->{client}		= $params{client} || die "No Client: $!";
	$self->{name}		= $params{name} if($params{name});
	$self->{heartbeat}	= $params{heartbeat} || "on";
	$self->{cmd}		= "screen_add $self->{name}\n";
	$self->{set}		= "screen_set $self->{name} name {$self->{client}->{name}}\n";
	$self->{set}	   .= "screen_set $self->{name} heartbeat $self->{heartbeat}\n";
	$self->{widgets}	= undef;
	bless ($self, $class);
	return $self;
}

sub add {
	my $self = shift;
	foreach (@_){
		push @{$self->{widgets}}, $_;
	}
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

IO::Lcdproc::Screen - Perl extension to connect to an LCDproc ready display.

=head1 SYNOPSIS

  use IO::Lcdproc::Client;
  use IO::Lcdproc::Screen;
  use IO::Lcdproc::Widget;

  my $client	= IO::Lcdproc::Client->new(name => "MYNAME");
  my $screen	= IO::Lcdproc::Screen->new(name => "screen", client => $client);
  my $title 	= IO::Lcdproc::Widget->new(
    name => "date", type => "title", screen => $screen
  );
  my $first	= IO::Lcdproc::Widget->new(
    name => "first", align => "center", screen => $screen, xPos => 1, yPos => 2
  );
  my $second	= IO::Lcdproc::Widget->new(
    name => "second", align => "center", screen => $screen, xPos => 1, yPos => 3
  );
  my $third	= IO::Lcdproc::Widget->new(
    name => "third", screen => $screen, xPos => 1, yPos => 4
  );
  $client->add( $screen );
  $screen->add( $title, $first, $second, $third );
  $client->connect() or die "cannot connect: $!";
  $client->initialize();

  $title->set("This is the title");
  $first->set("First Line");
  $second->set("Second line");
  $third->set("Third Line");


=head1 DESCRIPTION

Follow the example above. Pretty straight forward. You create a client, assign a screen,
add widgets, and then set the widgets.

=head2 EXPORT

None by default.



=head1 SEE ALSO

  IO::Lcdproc::Client, IO::Lcdproc::Widget.

=head1 AUTHOR

Juan C. Müller, E<lt>sputnik@nonetE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2005 by Juan C. Müller

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
