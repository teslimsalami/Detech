package com.example.burak.sleeptracker;

import android.app.Activity;
import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.provider.AlarmClock;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.TimePicker;
import android.widget.Toast;

import com.androidplot.util.PlotStatistics;
import com.androidplot.xy.BoundaryMode;
import com.androidplot.xy.LineAndPointFormatter;
import com.androidplot.xy.SimpleXYSeries;
import com.androidplot.xy.XYPlot;

import java.util.Calendar;
import java.util.concurrent.TimeUnit;

public class OpeningScreenActivity extends Activity
{
    private Button sleepButton, plotButton;
    private TimePicker timePicker;
    private SensorManager senSensorManager;
    private SensorController sc;
    private XYPlot historyPlot = null;
    private SimpleXYSeries historySeries = null;
    private boolean plotShown = false, sleeping = false;
    private TextView textView, textView2, textView3;

    private AlarmManager alarmManager;
    private PendingIntent pendingIntent;
    private static OpeningScreenActivity inst;
    private long alarmPeriodEnd = 0, alarmPeriodStart = 0;

    private String TAG = "OpeningScreenActivity";

    public static OpeningScreenActivity instance() {
        return inst;
    }

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.opening_screen);

        sleepButton = (Button) findViewById(R.id.sleepButton);
        plotButton = (Button) findViewById(R.id.plotButton);
        timePicker = (TimePicker) findViewById(R.id.timePicker);
        textView = (TextView) findViewById(R.id.textView);
        textView2 = (TextView) findViewById(R.id.textView2);
        textView3 = (TextView) findViewById(R.id.textView3);
        textView.setVisibility(View.GONE);
        textView2.setVisibility(View.GONE);
        alarmManager = (AlarmManager) getSystemService(ALARM_SERVICE);

        senSensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);

        sleepButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (sleeping) // stop sleeping
                {
                    sc.stopSensor();
                    sleepButton.setText("Start Sleeping");
                    timePicker.setVisibility(View.VISIBLE);
                    textView3.setVisibility(View.VISIBLE);
                    textView.setVisibility(View.GONE);
                    textView2.setVisibility(View.GONE);
                    sleeping = false;

                    alarmManager.cancel(pendingIntent);
                }
                else // start sleeping
                {
                    timePicker.setVisibility(View.GONE);
                    textView3.setVisibility(View.GONE);
                    Calendar calendar = Calendar.getInstance();
                    calendar.set(Calendar.HOUR_OF_DAY, timePicker.getCurrentHour());
                    calendar.set(Calendar.MINUTE, timePicker.getCurrentMinute());

                    if (System.currentTimeMillis() >= calendar.getTimeInMillis())
                        alarmPeriodEnd = calendar.getTimeInMillis() + 86400000;
                    else
                        alarmPeriodEnd = calendar.getTimeInMillis();

                    alarmPeriodStart = alarmPeriodEnd - 1800000;
                    if (alarmPeriodStart < System.currentTimeMillis())
                        alarmPeriodStart = System.currentTimeMillis();


                    int minutesStart = (int) ((alarmPeriodStart / (1000*60)) % 60);
                    int hoursStart   = (int) ((alarmPeriodStart / (1000*60*60) + 2) % 24);
                    int minutesEnd   = (int) ((alarmPeriodEnd / (1000*60)) % 60);
                    int hoursEnd     = (int) ((alarmPeriodEnd / (1000*60*60) + 2) % 24);
                    textView.setText(String.format("%02d:%02d - %02d:%02d", hoursStart, minutesStart, hoursEnd, minutesEnd));
                    textView.setVisibility(View.VISIBLE);
                    textView2.setVisibility(View.VISIBLE);
                    sc.clear();
                    sc.startSensor(alarmPeriodStart, alarmPeriodEnd);
                    sleepButton.setText("Stop");
                    sleeping = true;

                    soundAlarm(alarmPeriodEnd);
                }
            }
        });

        plotButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (plotShown)
                {
                    historyPlot.setVisibility(View.GONE);
                    if (!sleeping) {
                        timePicker.setVisibility(View.VISIBLE);
                        textView3.setVisibility(View.VISIBLE);
                    }
                    else
                    {
                        textView.setVisibility(View.VISIBLE);
                        textView2.setVisibility(View.VISIBLE);
                    }
                    sleepButton.setVisibility(View.VISIBLE);
                    plotButton.setText("How did I sleep?");
                    plotShown = false;
                }
                else
                {
                    historyPlot.setVisibility(View.VISIBLE);
                    timePicker.setVisibility(View.GONE);
                    textView3.setVisibility(View.GONE);
                    sleepButton.setVisibility(View.GONE);
                    textView.setVisibility(View.GONE);
                    textView2.setVisibility(View.GONE);
                    plotButton.setText("Go back");
                    plotShown = true;
                }
            }
        });

        historyPlot = (XYPlot) findViewById(R.id.historyPlot);

        historySeries = new SimpleXYSeries("");
        historySeries.useImplicitXVals();

        historyPlot.setRangeBoundaries(0, 300, BoundaryMode.FIXED);
        historyPlot.setDomainBoundaries(0, 100, BoundaryMode.AUTO);
        historyPlot.addSeries(historySeries, new LineAndPointFormatter(Color.BLACK, Color.BLACK, Color.BLACK, null));
        historyPlot.setDomainStepValue(5);
        historyPlot.setTicksPerRangeLabel(3);
        historyPlot.setDomainLabel("Time");
        historyPlot.setRangeLabel("Movement");
        historyPlot.getLegendWidget().setVisible(false); // remove the legend
        historyPlot.getGraphWidget().setMargins(20, 20, 30, 20);
        final PlotStatistics histStats = new PlotStatistics(1000, false);

        historyPlot.addListener(histStats);
        historyPlot.setVisibility(View.GONE);

        sc = new SensorController(senSensorManager, historyPlot, historySeries, OpeningScreenActivity.this);
    }

    public void soundAlarm(long alarmTime)
    {
        Intent myIntent = new Intent(OpeningScreenActivity.this, AlarmReceiver.class);
        pendingIntent = PendingIntent.getBroadcast(OpeningScreenActivity.this, 0, myIntent, 0);
        alarmManager.set(AlarmManager.RTC, alarmTime, pendingIntent);
    }
}
