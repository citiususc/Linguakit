use strict;
use warnings;
use utf8;
use open ':std', ':encoding(utf8)';
use Test::More tests => 2;
use Plack::Test;
use HTTP::Request;
use JSON;

use lib 'lib';
use lib 'api/lib';
require linguakit_api;

linguakit_api::run();
my $test = Plack::Test->create(linguakit_api->to_app);

my $request  = HTTP::Request->new( GET => '/ping' );
my $response = $test->request($request);

ok( $response->is_success, '[GET /ping] Successful request' );
is_deeply( $response->content, encode_json({status => 'ok'}), '[GET /ping] Correct content' );
