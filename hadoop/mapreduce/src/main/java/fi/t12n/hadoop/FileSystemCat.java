package fi.t12n.hadoop;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IOUtils;

import java.io.IOException;
import java.io.InputStream;

public class FileSystemCat {

    public static void main(String[] args) throws IOException {
        String uri = args[0];
        Configuration conf = new Configuration();
        FileSystem fs = FileSystem.getLocal(conf);
        InputStream in = null;
        in = fs.open(new Path(uri));
        IOUtils.copyBytes(in, System.out, 4096, true);
    }

}
