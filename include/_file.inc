O_RDONLY        equ 0
O_WRONLY        equ 1
O_RDWR          equ 2

PROT_READ       equ 1   ; 001   
PROT_WRITE      equ 2   ; 010
PROT_EXEC       equ 4   ; 100

MAP_PRIVATE     equ 02h
MAP_ANONYMOUS   equ 20h

O_DIRECTORY equ 0200000

struc stat {
    .dev_t      rd 1;     /* ID of device containing file */
    .ino_t      rd 1;     /* Inode number */
    .mode_t     rw 1;     /* File type and mode */
    .nlink_t    rw 1;     /* Number of hard links */
    .uid_t      rw 1;     /* User ID of owner */
    .gid_t      rw 1;     /* Group ID of owner */
    .s_dev_t    rd 1;     /* Device ID (if special file) */
    .off_t      rd 1;     /* Total size, in bytes */
    .blksize_t  rd 1;     /* Block size for filesystem I/O */
    .blkcnt_t   rd 1;     /* Number of 512B blocks allocated */

    ; /* Since Linux 2.6, the kernel supports nanosecond
    ;     precision for the following timestamp fields.
    ;     For the details before Linux 2.6, see NOTES. */

    ; struct timespec st_atim;  /* Time of last access */
    ; struct timespec st_mtim;  /* Time of last modification */
    ; struct timespec st_ctim;  /* Time of last status change */

    ; st_atime equ st_atim.tv_sec      /* Backward compatibility */
    ; st_mtime equ st_mtim.tv_sec
    ; st_ctime equ st_ctim.tv_sec
}

struc sizes {
    .str1           rb 1
    .filename       rb 1
    ; .str2           db 14
    .full_filename  rb 1
    .fd             db 4
    .all_size       db 4
}