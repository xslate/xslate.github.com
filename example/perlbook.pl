#!/usr/bin/env perl
use strict;
use warnings;
use Encode qw(encode_utf8);

use FindBin qw($Bin);
use Text::Markdown qw(markdown);

use Text::Xslate qw(mark_raw);

my $xslate = Text::Xslate->new(
    path      => ["$Bin/templates"],
);

my $books = {
    "978-0596520106" => {
        name  => "Learning Perl",
        pages => 352,
    },
    "978-0596000271" => {
        name  => "Programming Perl",
        pages => 1092,
    },
    "978-0596527242" => {
        name  => "Mastering Perl",
        pages => 352,
    },
    "978-0596001735" => {
        name  => "Perl Best Practices",
        pages => 544,
    },
};

my $see_also = markdown(<<'END_MD'); # an HTML generator
SEE ALSO
-----------------
* http://perl.com/
* http://perl.org/
* http://search.cpan.org/
END_MD

my $content = $xslate->render("perlbook.tx", {
    title    => "Perl Books",
    books    => $books,
    see_also => mark_raw($see_also),
});

print encode_utf8($content);

__END__
