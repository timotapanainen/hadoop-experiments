package fi.t12n.hadoop.mapreduce.ncdc;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mrunit.mapreduce.ReduceDriver;
import org.junit.Test;

import java.io.IOException;
import java.util.Arrays;

import static org.junit.Assert.*;

public class NcdcReducerTest {

    @Test
    public void testReduce() throws IOException {
        new ReduceDriver<Text, IntWritable, Text, IntWritable>()
        .withReducer(new NcdcReducer())
        .withInput(new Text("2015"), Arrays.asList(new IntWritable(10), new IntWritable(12)))
        .withOutput(new Text("2015"), new IntWritable(12))
        .runTest();
    }
}