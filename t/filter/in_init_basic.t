use strict;
use warnings FATAL => 'all';

use Apache::Test;
use Apache::TestRequest;
use Apache::TestUtil;

plan tests => 1;

my $content = "content ok\n";
my $expected = join '', $content, "init 1\n", "run 2\n";

my $location = '/TestFilter::in_init_basic';
my $response = POST_BODY $location, content => $content;
ok t_cmp($expected, $response, "test filter init functionality");