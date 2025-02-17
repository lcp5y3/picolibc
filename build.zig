const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const picolibc_dep = b.dependency("picolibc", .{
        .target = target,
        .optimize = optimize,
    });

    const libc = b.addStaticLibrary(.{
        .name = "c",
        .target = target,
        .optimize = optimize,
    });
    libc.addIncludePath(picolibc_dep.path("picolibc/include"));
    // b.addInstallHeaderFile();

    libc.addCSourceFiles(.{
        .root = picolibc_dep.path("newlib/libc/picolibc"),
        .files = &src_libc_picolib,
        .flags = &flags,
    });
    libc.addCSourceFiles(.{
        .root = picolibc_dep.path("newlib/libc/tinystdio"),
        .files = &src_libc_tinystdio,
        .flags = &flags,
    });
    libc.addCSourceFiles(.{
        .root = picolibc_dep.path("newlib/libc/xdr"),
        .files = &src_libc_xdr,
        .flags = &flags,
    });
    libc.addCSourceFiles(.{
        .root = picolibc_dep.path("newlib/libc/locale"),
        .files = &src_libc_locale,
        .flags = &flags,
    });

    const libm = b.addStaticLibrary(.{
        .name = "m",
        .target = target,
        .optimize = optimize,
    });

    libm.addCSourceFiles(.{
        .files = &src_libm,
        .flags = &flags,
    });

    const picocrt = b.addStaticLibrary(.{
        .name = "crt",
        .target = target,
        .optimize = optimize,
    });

    picocrt.addCSourceFiles(.{
        .files = &src_picocrt,
        .flags = &flags,
    });
}

const flags = [_][]const u8{
    "-nostdlib",
    "-D_LIBC",
    "-fno-common",
    "-Wall",
    "-Wextra",
};
const src_newlib = [_][]const u8{};
const src_libm = [_][]const u8{
    //machine
    // include
    // argz
    // ctype
    // errno
    // iconv
    // misc
    // picolib
};
const src_libc_picolib = [_][]const u8{
    "picosbrk.c",
    "dso_handle.c",
    "getauxval.c",
    "machine/x86/interrupt.c",
};

// posix
// search
// signal
// ssp
// stdlib
// time
// tinystdio
const src_libc_tinystdio = [_][]const u8{
    "asprintf.c",
    "atold_engine.c",
    "bufio.c",
    "clearerr.c",
    "dtox_engine.c",
    "ecvt.c",
    "ecvtf.c",
    "ecvtf_r.c",
    "ecvtl.c",
    "ecvtl_r.c",
    "ecvt_r.c",
    "fclose.c",
    "fcvt.c",
    "fcvtf.c",
    "fcvtf_r.c",
    "fcvtl.c",
    "fcvtl_r.c",
    "fcvt_r.c",
    "fdevopen.c",
    "feof.c",
    "ferror.c",
    "fflush.c",
    "fgetc.c",
    "fgets.c",
    "fgetwc.c",
    "fgetws.c",
    "fileno.c",
    "filestrget.c",
    "filestrputalloc.c",
    "filestrput.c",
    "filewstrget.c",
    "flockfile.c",
    "fmemopen.c",
    "fprintf.c",
    "fputc.c",
    "fputs.c",
    "fputwc.c",
    "fputws.c",
    "fread.c",
    "fscanf.c",
    "fseek.c",
    "fseeko.c",
    "ftell.c",
    "ftello.c",
    "ftox_engine.c",
    "ftrylockfile.c",
    "funlockfile.c",
    "funopen.c",
    "fwide.c",
    "fwprintf.c",
    "fwrite.c",
    "fwscanf.c",
    "gcvt.c",
    "gcvtf.c",
    "gcvtl.c",
    "getchar.c",
    "getdelim.c",
    "getline.c",
    "gets.c",
    "getwchar.c",
    "ldtoa_engine.c",
    "ldtox_engine.c",
    "matchcaseprefix.c",
    "mktemp.c",
    "perror.c",
    "printf.c",
    "putchar.c",
    "puts.c",
    "putwchar.c",
    "remove.c",
    "rewind.c",
    "scanf.c",
    "setbuf.c",
    "setbuffer.c",
    "setlinebuf.c",
    "setvbuf.c",
    "sflags.c",
    "snprintf.c",
    "snprintfd.c",
    "snprintff.c",
    "sprintf.c",
    "sprintfd.c",
    "sprintff.c",
    "sscanf.c",
    "strfromd.c",
    "strfromf.c",
    "strfroml.c",
    "strtod.c",
    "strtod_l.c",
    "strtof.c",
    "strtof_l.c",
    "strtoimax.c",
    "strtol.c",
    "strtold.c",
    "strtold_l.c",
    "strtol_l.c",
    "strtoll.c",
    "strtoll_l.c",
    "strtoul.c",
    "strtoul_l.c",
    "strtoull.c",
    "strtoull_l.c",
    "strtoumax.c",
    "swprintf.c",
    "swscanf.c",
    "tmpfile.c",
    "tmpnam.c",
    "ungetc.c",
    "ungetwc.c",
    "vasprintf.c",
    "vffprintf.c",
    "vffscanf.c",
    "vfiprintf.c",
    "vfiscanf.c",
    "vflprintf.c",
    "vflscanf.c",
    "vfmprintf.c",
    "vfmscanf.c",
    "vfprintf.c",
    "vfscanf.c",
    "vfwprintf.c",
    "vfwscanf.c",
    "vprintf.c",
    "vscanf.c",
    "vsnprintf.c",
    "vsprintf.c",
    "vsscanf.c",
    "vswprintf.c",
    "vswscanf.c",
    "vwprintf.c",
    "vwscanf.c",
    "wprintf.c",
    "wscanf.c",
    "sprintf_s.c",
    // toto
    "compare_exchange.c",
    "exchange.c",
    // toto
    "fdopen.c",
    "fopen.c",
    "freopen.c",
};
const src_libc_xdr = [_][]const u8{
    "xdr_array.c",
    "xdr.c",
    "xdr_float.c",
    "xdr_mem.c",
    "xdr_private.c",
    "xdr_rec.c",
    "xdr_reference.c",
    "xdr_sizeof.c",
    "xdr_stdio.c",
};
const src_libc_locale = [_][]const u8{
    "duplocale.c",
    "freelocale.c",
    "getlocalename_l.c",
    "locale.c",
    "localeconv.c",
    "lnumeric.c",
    "newlocale.c",
    "timelocal.c",
    "uselocale.c",
};
const src_picocrt = [_][]const u8{};
