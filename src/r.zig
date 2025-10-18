// Welcome to rnm/r.zig
//
// This file contains the logic for making random names.

const std = @import("std");

const VOWELS = "aeiou";
const CONSONANTS = "bcdfghjklmnpqrstvwxyz";

// Helper to pick a random char
fn picker(rand: std.Random, src: []const u8) u8 {
    return src[rand.intRangeAtMost(usize, 0, src.len - 1)];
}

pub fn makeName(buffer: []u8, length: u8, first: ?u8) ![]u8 {
    const rand = std.crypto.random;

    // Fallback to random
    var actual_length = length;
    if (actual_length == 0) {
        actual_length = rand.intRangeAtMost(u8, 3, 10);
    }

    if (actual_length > buffer.len) return error.BufferTooSmall;
    const name = buffer[0..actual_length];

    // 1st letter
    var first_char: u8 = undefined;
    if (first) |f| {
        first_char = std.ascii.toLower(f);
    } else {
        const first_is_vowel = rand.boolean();
        first_char = picker(rand, if (first_is_vowel) VOWELS else CONSONANTS);
    }
    name[0] = first_char;

    // Alternator
    var is_vowel: bool = std.mem.indexOfScalar(u8, VOWELS, name[0]) != null;

    for (name[1..]) |*c| {
        is_vowel = !is_vowel;
        c.* = picker(rand, if (is_vowel) VOWELS else CONSONANTS);
    }

    return name;
}
