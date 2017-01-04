package POSIX::Poll {

	use NativeCall;
	use NativeHelpers::CStruct;
	use NativeHelpers::Blob;

	class Pollfd is repr('CStruct') is export {
	    has int32 $.fd;
	    has int16 $.events;
	    has int16 $.revents;
	}

	sub one_poll(Pollfd, uint64, uint32) returns int32 is native is symbol('poll') is export(:native) { * }

	sub multi_poll(Pointer, uint64, uint32) returns int32 is native is symbol('poll') is export(:native){ * }

#	sub poll(Array[Pollfd] :@fd, :$events, :$timeout) returns int32 is export {
	sub poll( :@fd, :$events, :$timeout) returns int32 is export {
		my $nfd = LinearArray[Pollfd].new(@fd.elems);
		for @fd.kv -> $i, $e {
			$nfd[$i] = $e;
		}
		my uint64 $nfds = $events;
		my uint32 $to = $timeout * 1000;
		multi_poll($nfd.Pointer, $nfds, $to);
	}
}

=begin pod

=head1 SYNOPSIS


=head1 DESCRIPTION


=head2 SUBS

=over

=item poll(:$fd, :$events, :$timeout)

timeout in seconds (number, rat)

=back

=head1 SEE ALSO


=end pod
