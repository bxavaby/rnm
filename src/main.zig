// Welcome to rnm/main.zig
//
// rnm, which stands for 'random name maker', is my first ever
// project in zig!
//
// It is a command-line utility that generates random, READABLE
// names by following a set of strict rules:
//
// - Names must be at least 3 characters long
// - Names must be at most 10 characters long
// - Vowels and consonants must alternate at all times
//
// Since there is a CLI, it is crucial to introduce flags,
// as well as usage instructions, as follows:
//
// - --help/-help/-h/-H: shows the help message
// - --version/-version/-v/-V: shows the version number
// - -l/-L (followed by a number 3-10): defines the length
// - -f/-F (followed by a letter): defines the first letter
//
// A total of 2 additional files are necessary for this project,
// ensuring organization and clarity:
//
// - cli.zig: commands logic
// - r.zig: generator logic
//
// Licensed under the MIT License.
// Copyright (c) 2025 bxavaby
//
// Repo: https://github.com/bxavaby/rnm

const std = @import("std");
const rnm = @import("rnm");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    // Parse cli args
    const options = rnm.cli.parseArgs(allocator) catch |err| switch (err) {
        error.MissingLength => {
            rnm.cli.printHelpWithEr("missing argument after -l");
            return;
        },
        error.InvalidLength => {
            rnm.cli.printHelpWithEr("length must be 3-10");
            return;
        },
        error.MissingFirstLetter => {
            rnm.cli.printHelpWithEr("missing argument after -f");
            return;
        },
        error.InvalidFirstLetter => {
            rnm.cli.printHelpWithEr("first letter must be a single character a-z");
            return;
        },
        error.UnknownFlag => {
            rnm.cli.printHelpWithEr("unknown flag");
            return;
        },
        else => |e| {
            std.debug.print("unexpected error: {any}\n", .{e});
            return;
        },
    };

    if (options.help) {
        std.debug.print("{s}\n{s}\n", .{ rnm.cli.LOGO, rnm.cli.HELP });
        return;
    }

    if (options.version) {
        std.debug.print("rnm {s}\n", .{rnm.cli.VERSION});
        return;
    }

    // Local stack buffer for the name
    var buffer: [10]u8 = undefined;
    const name = try rnm.r.makeName(&buffer, options.length, options.first);

    std.debug.print("{s}\n", .{name});
}
