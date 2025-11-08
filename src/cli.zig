// Welcome to rnm/src/cli.zig
//
// This file contains the logic needed for rnm
// to process flags, parameters, as well as other
// hard-coded components, such as the output for the
// version and help messages.

const std = @import("std");

pub const LOGO =
    \\    _________  ____ ___
    \\   / ___/ __ \/ __ `__ \
    \\  / /  / / / / / / / / /
    \\ /_/  /_/ /_/_/ /_/ /_/
    \\
    \\:::::::::::::::::::::::
    \\ >_ ARR bxavaby 2025  +
    \\:::::::::::::::::::::::
    \\
    \\+---------------------+
    \\|  random name maker  |
    \\|  command-line tool  |
    \\+---------------------+
;

pub const VERSION = "v0.1.0";

pub const HELP =
    \\
    \\Usage: rnm [options]
    \\
    \\Options:
    \\  -h, --help             Display this help message
    \\  -v, --version          Display the version number
    \\  -l, --length <3-10>    Define the length of the name
    \\  -f, --first <char>     Define the first letter of the name
;

pub const CliOpts = struct {
    length: u8 = 0,
    first: ?u8 = null,
    help: bool = false,
    version: bool = false,
};

pub fn parseArgs(allocator: std.mem.Allocator) !CliOpts {
    var args = try std.process.argsWithAllocator(allocator);
    defer args.deinit();

    var options = CliOpts{};

    _ = args.next();

    while (args.next()) |arg| {
        if (std.mem.eql(u8, arg, "-h") or std.mem.eql(u8, arg, "--help") or std.mem.eql(u8, arg, "help") or std.mem.eql(u8, arg, "-H")) {
            options.help = true;
        } else if (std.mem.eql(u8, arg, "-v") or std.mem.eql(u8, arg, "--version") or std.mem.eql(u8, arg, "version") or std.mem.eql(u8, arg, "-V")) {
            options.version = true;
        } else if (std.mem.eql(u8, arg, "-l") or std.mem.eql(u8, arg, "--length") or std.mem.eql(u8, arg, "-L")) {
            const length_str = args.next() orelse return error.MissingLength;
            const length = try std.fmt.parseInt(u8, length_str, 10);
            if (length < 3 or length > 10) return error.InvalidLength;
            options.length = length;
        } else if (std.mem.eql(u8, arg, "-f") or std.mem.eql(u8, arg, "--first") or std.mem.eql(u8, arg, "-F")) {
            const first_str = args.next() orelse return error.MissingFirstLetter;
            if (first_str.len != 1) return error.InvalidFirstLetter;
            if (!std.ascii.isAlphabetic(first_str[0])) return error.InvalidFirstLetter;
            options.first = first_str[0];
        } else {
            return error.UnknownFlag;
        }
    }

    return options;
}

pub fn printHelpWithEr(msg: []const u8) void {
    std.debug.print("error: {s}\n{s}\n", .{ msg, HELP });
}
