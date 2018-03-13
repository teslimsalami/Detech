package com.example.burak.sleeptracker;

import android.app.Activity;
import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.ComponentName;
import android.content.Intent;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.media.Ringtone;
import android.media.RingtoneManager;
import android.net.Uri;
import android.util.Log;

import com.androidplot.xy.SimpleXYSeries;
import com.androidplot.xy.XYPlot;

import java.util.ArrayList;
import java.util.List;

public class SensorController implements SensorEventListener
{
    private long lastUpdate;
    private float last_x, last_y, last_z;
    private int countDowntoStart = 10;
    private SensorManager senSensorManager;
    private Sensor senAccelerometer;
    private List<Float>[] rollingAverage = new List[3];
    private static final int MAX_SAMPLE_SIZE = 5; // moving average filter length
    private XYPlot historyPlot = null;
    private SimpleXYSeries historySeries = null;
    private static final int THRESHOLD = 30; // movement threshold for wake-up
    private OpeningScreenActivity mainActivity;
    private long lastTimeSounded = 0;
    private long alarmPeriodEnd = 0, alarmPeriodStart = 0;

    private String TAG = "SensorController";

    // constructor
    public SensorController(SensorManager sm, XYPlot plot, SimpleXYSeries series, Activity actMain)
    {
        senSensorManager = sm;
        senAccelerometer = senSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
        rollingAverage[0] = new ArrayList<Float>();
        rollingAverage[1] = new ArrayList<Float>();
        rollingAverage[2] = new ArrayList<Float>();

        historyPlot = plot;
        historySeries = series;
        mainActivity = (OpeningScreenActivity) actMain;
    }

    // Called whenever a new orSensor reading is taken.
    @Override
    public synchronized void onSensorChanged(SensorEvent sensorEvent) {
        Sensor mySensor = sensorEvent.sensor;

        if (mySensor.getType() == Sensor.TYPE_ACCELEROMETER)
        {
            // uncomment for moving average filtering -------------------------------
            rollingAverage[0] = roll(rollingAverage[0], sensorEvent.values[0]);
            rollingAverage[1] = roll(rollingAverage[1], sensorEvent.values[1]);
            rollingAverage[2] = roll(rollingAverage[2], -sensorEvent.values[2]);
            float x = averageList(rollingAverage[0]);
            float y = averageList(rollingAverage[1]);
            float z = averageList(rollingAverage[2]);
            // ----------------------------------------------------------------------

            long curTime = System.currentTimeMillis();
            if ((curTime - lastUpdate) > 50)
            {
                long diffTime = (curTime - lastUpdate);
                lastUpdate = curTime;

                float speed = (float) Math.sqrt(Math.pow((x-last_x), 2) + Math.pow((y-last_y), 2)+ Math.pow((z-last_z), 2)) / diffTime * 10000;

                last_x = x;
                last_y = y;
                last_z = z;

                if (countDowntoStart > 0)
                    countDowntoStart--;
                else
                {
                    // Log.e(TAG, "speed: " + speed);
                    historySeries.addLast(null, speed);
                    historyPlot.redraw();

                    long currentTime = System.currentTimeMillis();
                    if (currentTime >= alarmPeriodStart && currentTime <= alarmPeriodEnd)
                    {
                        /*Log.e(TAG, "start: " + alarmPeriodStart);
                        Log.e(TAG, "end: " + alarmPeriodEnd);
                        Log.e(TAG, "now: " + currentTime);*/
                        if (speed > THRESHOLD)
                        {
                            // Log.e(TAG, "speed: " + speed);
                            // sound the alarm now
                            if (currentTime - lastTimeSounded > 1000) {
                                lastTimeSounded = currentTime;
                                mainActivity.soundAlarm(lastTimeSounded);
                            }
                        }
                    }
                }
            }
        }
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int i) {
    }


    public void startSensor(long start, long end)
    {
        senSensorManager.registerListener(this, senAccelerometer, SensorManager.SENSOR_DELAY_NORMAL);
        lastUpdate = System.currentTimeMillis();
        // Log.e(TAG, "sensor should be started");
        alarmPeriodStart = start;
        alarmPeriodEnd = end;
    }

    public void stopSensor()
    {
        senSensorManager.unregisterListener(this);
    }

    public void clear()
    {
        rollingAverage[0] = new ArrayList<Float>();
        rollingAverage[1] = new ArrayList<Float>();
        rollingAverage[2] = new ArrayList<Float>();
        countDowntoStart = 10;
        while (historySeries.size() != 0)
            historySeries.removeLast();
    }

    public List<Float> roll(List<Float> list, float newMember)
    {
        if(list.size() == MAX_SAMPLE_SIZE){
            list.remove(0);
        }
        list.add(newMember);
        return list;
    }

    public float averageList(List<Float> tallyUp)
    {
        float total=0;
        for(float item : tallyUp ){
            total+=item;
        }
        total = total/tallyUp.size();

        return total;
    }
}
