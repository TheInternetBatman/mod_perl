package TestAPR::lib;

use strict;
use warnings FATAL => 'all';

use Apache::Test;

use APR::Lib ();

sub handler {
    my $r = shift;

    plan $r, tests => 3;

    my $blen = 10;
    my $bytes = APR::generate_random_bytes(10);
    ok length($bytes) == $blen;

    my $status = APR::password_validate("one", "two");

    ok $status != 0;

    my $str= APR::strerror($status);

    print "strerror=$str\n";

    ok $str eq 'passwords do not match';

    0;
}

1;
