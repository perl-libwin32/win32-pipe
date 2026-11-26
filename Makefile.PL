use 5.006; #perl 5.6 required by use warnings;
use strict;
use warnings;
use Config qw(%Config);
use ExtUtils::MakeMaker;

unless ($^O eq "MSWin32" || $^O eq "cygwin") {
    die "OS unsupported\n";
}

my %param = (
    NAME          => 'Win32::Pipe',
    VERSION_FROM  => 'Pipe.pm',
    OBJECT        => 'Cpipe$(OBJ_EXT) Pipe$(OBJ_EXT)',
    XS            => { 'Pipe.xs' => 'Pipe.cpp' },
);
$param{NO_META} = 1 if eval "$ExtUtils::MakeMaker::VERSION" >= 6.10_03;
$param{INC} = '-GX' if $Config{'cc'} =~ /^cl/i;
WriteMakefile(%param);

# Run xsubpp through $(XSUBPPRUN), as MakeMaker's own .xs.c rule does.
# MakeMaker quotes the program path in $(PERL), and nmake splits an
# unquoted first argument after a quoted program at its first "/". So
# a rule starting '$(PERL) -I$(PERL_ARCHLIB)' fails for a perl whose
# archlib uses forward slashes. With an archlib of C:/perl/lib, perl
# gets -IC: as an option and tries to run /perl/lib as its script.
sub MY::xs_c {
    '
.xs.cpp:
	$(XSUBPPRUN) $(XSPROTOARG) $(XSUBPPARGS) $*.xs >xstmp.c && $(MV) xstmp.c $*.cpp
';
}
