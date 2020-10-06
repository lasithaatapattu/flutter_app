package com.example.net_ninja
import android.app.AlarmManager
import android.app.PendingIntent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.os.Bundle
import android.os.PersistableBundle
import android.widget.Toast
import io.flutter.plugin.common.EventChannel
import java.util.*

class MainActivity: FlutterActivity() {
    private lateinit var mSensorManager: SensorManager
    private lateinit var mAccelerometer: Sensor
    private val CHANNEL = "samples.flutter.dev/battery"
    private val EVENT_CHANNEL = "samples.flutter.dev/syncorientation"

    private val ALARM_EVENT="samples.flutter.alarm"
    lateinit var pendingIntent: PendingIntent

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        mSensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        mAccelerometer = mSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL).setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(
                    arguments: Any?,
                    events: EventChannel.EventSink?
            ) {
                emitDeviceOrientation(events)
            }

            override fun onCancel(arguments: Any?) {

            }

        })
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, ALARM_EVENT).setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(
                    arguments: Any?,
                    events: EventChannel.EventSink?
            ) {
                emitAlarm(events)
            }

            override fun onCancel(arguments: Any?) {

            }

        })
    }
    private fun emitAlarm(events: EventChannel.EventSink?){
        initialize()
        events?.success("true")
    }

    private fun emitDeviceOrientation(events: EventChannel.EventSink?) {
        mSensorManager.registerListener(object : SensorEventListener {
            override fun onSensorChanged(sensorEvent: SensorEvent?) {
                if (sensorEvent?.sensor?.type == Sensor.TYPE_ACCELEROMETER) {
                    if (Math.abs(sensorEvent.values[1]) > Math.abs(sensorEvent.values[0])) {
                        //Mainly portrait
                        if (sensorEvent.values[1] > 0.75) {
                            events?.success("Portrait")
                        } else if (sensorEvent.values[1] < -0.75) {
                            events?.success("Portrait Upside down")
                        }
                    } else {
                        //Mainly landscape
                        if (sensorEvent.values[0] > 0.75) {
                            events?.success("Landscape Right")
                        } else if (sensorEvent.values[0] < -0.75) {
                            events?.success("Landscape Left")
                        }
                    }
                }
            }

            override fun onAccuracyChanged(
                    sensor: Sensor?,
                    accuracy: Int
            ) {

            }
        }, mAccelerometer, SensorManager.SENSOR_DELAY_NORMAL)
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }
    fun initialize(){

            val myIntent = Intent(this@MainActivity, MyAlarmService::class.java)
            pendingIntent = PendingIntent.getService(this@MainActivity, 0, myIntent, 0)
            val alarmManager: AlarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
            val calendar: Calendar = Calendar.getInstance()
            calendar.timeInMillis = System.currentTimeMillis()
            calendar.add(Calendar.SECOND, 5)
            alarmManager.set(AlarmManager.RTC_WAKEUP, calendar.timeInMillis, pendingIntent)
            Toast.makeText(baseContext, "Starting Service Alarm", Toast.LENGTH_LONG).show()

//            val alarmManager: AlarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
//            alarmManager.cancel(pendingIntent)


    }
}

