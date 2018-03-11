package fi.t12n.hadoop;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

public class ToolTest extends Configured implements Tool {

    @Override
    public int run(String[] strings) throws Exception {
        Configuration c = getConf();
        System.out.println(c.get("fs.defaultFS"));
        return 0;
    }

    public static void main(String[] args) throws Exception {
        System.exit(ToolRunner.run(new ToolTest(), args));
    }
}
