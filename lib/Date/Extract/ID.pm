package Date::Extract::ID;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

sub new {
    my $class = shift;
    my %args = (
        format => 'DateTime',
        returns => 'first',
        prefers => 'nearest',
        time_zone => 'floating',
        @_,
    );

    if ($args{format} ne 'DateTime') {
        die "Invalid `format` passed to constructor: expected `DateTime'.";
    }

    if ($args{returns} ne 'first') {
        die "Invalid `returns` passed to constructor: expected `first'.";
    }

    if ($args{prefers} ne 'nearest') {
        die "Invalid `prefers` passed to constructor: expected `nearest'.";
    }

    my $self = bless \%args, ref($class) || $class;

    return $self;
}

sub extract {
    state $parser = do {
        require DateTime::Format::Alami::ID;
        DateTime::Format::Alami::ID->new;
    };

    my $self = shift;
    my $text = shift;
    my %args = @_;

    # using extract as a class method
    $self = $self->new
        if !ref($self);

    $parser->parse_datetime($text);
}

1;
# ABSTRACT: Extract probable dates from Indonesian text

=head1 SYNOPSIS

 my $parser = Date::Extract::ID->new();
 my $dt = $parser->extract($arbitrary_text)
     or die "No date found.";
 return $dt->ymd;


=head1 DESCRIPTION

This is a version of L<Date::Extract>-compatible module to handle Indonesian
text. Underneath, it uses L<DateTime::Format::Alami::ID> instead of
L<DateTime::Format::Natural> (because the latter does not handle non-English
text). So actually this module is just a wrapper for
DateTime::Format::Alami::ID.


=head1 SEE ALSO

L<Date::Extract>, L<DateTime::Format::Alami>

=cut
