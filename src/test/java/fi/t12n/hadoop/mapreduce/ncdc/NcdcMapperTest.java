package fi.t12n.hadoop.mapreduce.ncdc;

import org.apache.hadoop.mrunit.mapreduce.MapDriver;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.junit.Test;

import java.io.IOException;

import static org.junit.Assert.*;

public class NcdcMapperTest {

    @Test
    public void testMap() throws IOException {
        new MapDriver<LongWritable, Text, Text, IntWritable>()
                .withMapper(new NcdcMapper())
                .withInput(new LongWritable(0), new Text("0043012650999991949032412004+62300+010750FM-12+048599999V0202701N00461220001CN0500001N9+01111+99999999999"))
                .withOutput(new Text("1949"), new IntWritable(111))
                .runTest();
    }
}