use v6;
use Test;
use POSIX::Poll;

plan 1;

my $timeout = 2; # Seconds
my Pollfd @fd = Pollfd.new(fd => 0, events => 1, revents => 0);

my uint64 $events = @fd.elems;
my $polled = poll(:@fd, :$events, :$timeout);
$polled.gist.say;
is $polled, 0, 'No poll';
