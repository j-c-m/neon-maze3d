#!/usr/bin/perl
use strict;
use warnings;

# Specify the path to your HTML file
my $file_path = "./neon-maze3d.html";

# Read the file content
open(my $fh, '<', $file_path) or die "Cannot open file '$file_path': $!\n";
my $content = do { local $/; <$fh> }; # Slurp the entire file
close($fh);

# Extract the Git commit command
if ($content =~ /\/\/\s*git commit -m "Version \d+\.\d+:.*?"\s*\S+/) {
    my $git_command = $&; # $& is the matched string
    $git_command =~ s/\/\/\s*//; # Remove the comment prefix
    print "Extracted Git command: $git_command\n";

    # Execute the Git command
    my $result = system($git_command);
	if ($result == 0) {
        print "Git command executed successfully.\n";
    } else {
        print "Error executing Git command: $!\n";
        exit 1;
    }
} else {
    print "No Git commit command found in the file.\n";
    exit 1;
}
