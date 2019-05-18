#!/usr/bin/env perl

sub identify {
	my $serv = "freenode";
	my $url = "freenode.net";
	my $user = "jumper149";
	my $cmd = "gpg --quiet --for-your-eyes-only --no-tty --decrypt ~/.password-store/$url/$user.gpg";
	my $pass = `$cmd`;
	my $server = Irssi::server_find_chatnet($serv);
	$server->command("MSG NickServ IDENTIFY $pass");
}

Irssi::command_bind('identifyme', 'identify');
