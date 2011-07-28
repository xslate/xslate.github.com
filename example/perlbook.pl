#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

use Encode qw(encode_utf8);

use FindBin qw($Bin);
use Text::Markdown qw(markdown);

use Text::Xslate qw(mark_raw);

my $xslate = Text::Xslate->new(
    path      => ["$Bin/templates"],
);

my $books = {
    "978-0596000271" => {
        name  => "Programming Perl",
        pages => 1092,
    },

    # Programming Perl in Russian
    "978-5932860205" => {
        name => "Программирование на Perl",
        pages => 1152,
    },

    # Programming Perl in Japanese
    "978-4873110967" => {
        name  => "プログラミングPerl Vol.1",
        pages => 708,
    },
    "978-4873110974" => {
        name  => "プログラミングPerl Vol.2",
        pages => 1303,
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
