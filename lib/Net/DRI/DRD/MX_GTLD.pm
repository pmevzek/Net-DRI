## Domain Registry Interface, MX Registry Driver for GTLDs
##
## Copyright (c) 2015 Patrick Mevzek <netdri@dotandco.com>. All rights reserved.
##           (c) 2015 Michael Holloway <michael@thedarkwinter.com>. All rights reserved.
##           (c) 2015 Paulo Jorge <paullojorgge@gmail.com>. All rights reserved.
##
## This file is part of Net::DRI
##
## Net::DRI is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## See the LICENSE file that comes with this distribution for more details.
####################################################################################################

package Net::DRI::DRD::MX_GTLD;

use strict;
use warnings;
use Data::Dumper;

use base qw/Net::DRI::DRD/;

use DateTime::Duration;
use Net::DRI::Util;

__PACKAGE__->make_exception_for_unavailable_operations(qw/contact_transfer contact_transfer_stop contact_transfer_query contact_transfer_accept contact_transfer_refuse/);

=pod

=head1 NAME

Net::DRI::DRD::MX_GTLD - MX GTLD Registry Driver for Net::DRI

=head1 DESCRIPTION

Please see the README file for details.

Additional domain extension MX New Generic TLDs. Note this is separate from MX ccTLD Driver as the systems differ.

MX utilises the following standard extensions. Please see the test files for more examples.

=head3 L<Net::DRI::Protocol::EPP::Extensions::secDNS> urn:ietf:params:xml:ns:secDNS-1.1

=head3 L<Net::DRI::Protocol::EPP::Extensions::GracePeriod> urn:ietf:params:xml:ns:rgp-1.0

=head3 L<Net::DRI::Protocol::EPP::Extensions::LaunchPhase> urn:ietf:params:xml:ns:launch-1.0 [not implemented on server yet]

=head1 SUPPORT

For now, support questions should be sent to:

E<lt>netdri@dotandco.comE<gt>

Please also see the SUPPORT file in the distribution.

=head1 SEE ALSO

E<lt>http://www.dotandco.com/services/software/Net-DRI/E<gt>

=head1 AUTHOR

Paulo Jorge, E<lt>paullojorgge@gmail.comE<gt>

=head1 COPYRIGHT
Copyright (c) 2015 Patrick Mevzek <netdri@dotandco.com>.
          (c) 2015 Michael Holloway <michael@thedarkwinter.com>.
          (c) 2015 Paulo Jorge <paullojorgge@gmail.com>.
All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

See the LICENSE file that comes with this distribution for more details.

=cut

####################################################################################################

sub new
{
 my $class=shift;
 my $self=$class->SUPER::new(@_);
 $self->{info}->{host_as_attr}=0;
 $self->{info}->{contact_i18n}=1;
 return $self;
}

sub periods  { return map { DateTime::Duration->new(years => $_) } (1..10); }
sub name     { return 'MX_GTLD'; }

sub tlds { return qw/lat/ ; }

sub object_types { return ('domain','contact','ns'); }
sub profile_types { return qw/epp/; }

sub transport_protocol_default
{
 my ($self,$type)=@_;
 return ('Net::DRI::Transport::Socket',{},'Net::DRI::Protocol::EPP::Extensions::MX_GTLD',{}) if $type eq 'epp';
}

####################################################################################################

1;