use Irssi;

$VERSION = '1.0';
%IRSSI = (
    authors     => 'Robert Alm Nilsson',
    contact     => 'rorialni@gmail.com',
    name        => 'connect_join',
    description => 'This script lets you specify one or more channels '
    . 'to join in the connect command or after -c when you start irssi.',
    license     => 'Public Domain',
);
$channels = '';
%join_on_connect = ();

sub connect_failed {
    my $server = $_[0];
    my $port = $server->{port};
    my $password = $server->{password};
    my $nick = $server->{nick};
    my $full_addr = $server->{address};
    $full_addr =~ /(.*):(.*)/;
    my $address = $1;
    $channels = $2;
    if (!$address || !$channels) {
        return;
    }
    $join_on_connect{$address} = 1;
    Irssi::print("Trying server $address and channels $channels");
    Irssi::command("connect $address");
}

sub connected_maybe {
    my $server = $_[0];
    if (!$server || !$server->{connected}
        || (%join_on_connect{$server->{chatnet}} != 1
            && %join_on_connect{$server->{address}} != 1)) {
        return;
    }
    delete($join_on_connect{$server->{chatnet}});
    delete($join_on_connect{$server->{address}});
    Irssi::print("Joining $channels");
    $server->channels_join($channels, 0);
}

Irssi::signal_add_last('server connect failed', \&connect_failed);
Irssi::signal_add_last('server incoming', \&connected_maybe);
