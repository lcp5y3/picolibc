const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // const picolibc_dep = b.dependency("picolibc", .{
    //     .target = target,
    //     .optimize = optimize,
    // });

    const libc = b.addStaticLibrary(.{
        .name = "c",
        .target = target,
        .optimize = optimize,
    });

    libc.addCSourceFiles(.{
        .files = src_newlib,
        .flags = .{},
    });

    const libm = b.addStaticLibrary(.{
        .name = "m",
        .target = target,
        .optimize = optimize,
    });

    libm.addCSourceFiles(.{
        .files = src_libm,
        .flags = .{},
    });

    const picocrt = b.addStaticLibrary(.{
        .name = "crt",
        .target = target,
        .optimize = optimize,
    });

    picocrt.addCSourceFiles(.{
        .files = src_picocrt,
        .flags = .{},
    });
}

const src_newlib = [_][]const u8{};
const src_libm = [_][]const u8{};
const src_picocrt = [_][]const u8{};
