package TestCompat::conn_rec;

use strict;
use warnings FATAL => 'all';

use Apache::TestUtil;
use Apache::Test;

use Apache::compat ();

use Socket qw(sockaddr_in inet_ntoa);

use Apache::Constants qw(OK);

sub handler {

     my $r = shift;

     my $c = $r->connection;

     plan $r, tests => 4;

     Apache::compat::override_mp2_api('Apache::Connection::local_addr');
     my ($local_port, $local_addr) = sockaddr_in($c->local_addr);
     Apache::compat::restore_mp2_api('Apache::Connection::local_addr');
     t_debug inet_ntoa($local_addr) . " :$local_port";
     ok $local_port;
     ok inet_ntoa($local_addr);

     Apache::compat::override_mp2_api('Apache::Connection::remote_addr');
     my ($remote_port, $remote_addr) = sockaddr_in($c->remote_addr);
     Apache::compat::restore_mp2_api('Apache::Connection::remote_addr');
     t_debug inet_ntoa($remote_addr) . " :$remote_port";
     ok $remote_port;
     ok inet_ntoa($remote_addr);

     OK;
}

1;
