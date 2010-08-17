#!/usr/bin/perl -w
use strict;
BEGIN { binmode STDOUT, ':utf8' }

use PPI;
use PPI::HTML;

use Text::Xslate qw(mark_raw);

my $script = PPI::Document->new('example/perlbook.pl');

my $hl = PPI::HTML->new();

my $tx = Text::Xslate->new(
    path  => "tool/templates",
);

my $html     = $hl->html($script);
$html =~ s{<br>\n}{\n}xmsg; # grr...

my $template = do {
    open my $in, "<", "example/templates/perlbook.tx" or die $!;
    local $/;
    <$in>;
};

my $output = `$^X example/perlbook.pl`;

print $tx->render('intro.tx',
    {
        script   => mark_raw($html),
        template => $template,
        output   => $output,
    }
);
