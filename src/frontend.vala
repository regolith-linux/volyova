using GLib;
using Fuse;
using Posix;

const string filename = "hello";
const string contents = "Hello World!\n";

/*
 * This is a simplified Vala translation of the libfuse helloworld 
 * example: https://github.com/libfuse/libfuse/blob/master/example/hello.c 
 */
int initialize(string[] args)
{
    Fuse.Operations oper = Fuse.Operations() {
        getattr = GetAttr,
        readdir = ReadDir,
        open = Open,
        read = Read
    };
    
    Fuse.main(args, oper, null);
    
	return 0;
}

private int GetAttr(string path, Posix.Stat* stbuf) {
    int res = 0;
    
    if (path == "/") {
        stbuf->st_mode = S_IFDIR | 0755;
        stbuf->st_nlink = 2;
    } else if (filename == path.substring(1)) {
        stbuf->st_mode = S_IFREG | 0444;
        stbuf->st_nlink = 1;
        stbuf->st_size = contents.length;
    } else {
        res = -ENOENT;
    }
    
    return res;
}

private int ReadDir(string path, void* buf, FillDir filler, off_t offset, ref Fuse.FileInfo fi) {
    if (path != "/") {
        return -ENOENT;
    }
    
    filler(buf, ".", null, 0);
    filler(buf, "..", null, 0);
    filler(buf, filename, null, 0);
    
    return 0;
}

private int Open(string path, ref Fuse.FileInfo fi) {
    if (filename != path.substring(1))
        return -ENOENT;
            
    if ((fi.flags & O_ACCMODE) != O_RDONLY)
        return -EACCES;
    
    return 0;
}

private int Read(string path, char* buf, size_t size, off_t offset, ref Fuse.FileInfo fi) {
    size_t len;

    if (filename != path.substring(1)) {
       return -ENOENT;
    }
    
    len = contents.length;
    if (offset < len) {
        if (offset + size > len) {
            size = len - offset;
        }
        
        memcpy(buf, contents.substring((int) offset), size);
    } else {
        size = 0;
    }
            
    return (int) size;
}
