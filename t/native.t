use v6;
use Test;
use POSIX::Poll :ALL;

plan 1;

my uint32 $timeout = 1; # Miliseconds
my $readfd = Pollfd.new(fd => 0, events => 1, revents => 0);

my uint64 $elems = $readfd.elems;
my $polled = one_poll($readfd, $elems, $timeout);
is $polled, 0, 'No poll';

# $polled = multi_poll($readfd.Pointer, $elems, $timeout);
# is $polled, 0, 'No poll';
