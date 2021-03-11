package myflutternote.my_flutter_note

import android.bluetooth.BluetoothAdapter
import android.content.Intent
import android.net.wifi.WifiManager
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "flutterExamples/bluetooth"

    private val REQUEST_ENABLE_BT = 0
    lateinit var mBlueAdapter : BluetoothAdapter
    lateinit var wifi : WifiManager

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        wifi = applicationContext.getSystemService(WIFI_SERVICE) as WifiManager
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            when(call.method) {
                "onBluetooth" -> {
                    val stringResult = turnOnBluetooth()
                    if (stringResult.isNotEmpty()) {
                        result.success(stringResult)
                    } else {
                        result.error("UNAVAILABLE", "Ошибка включения", null)
                    }
                }
                "offBluetooth" -> {
                    val stringResult = turnOffBluetooth()
                    if (stringResult.isNotEmpty()) {
                        result.success(stringResult)
                    } else {
                        result.error("UNAVAILABLE", "Ошибка отключения", null)
                    }
                }
                "switchWifi" -> {
                    switchWifi()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun turnOnBluetooth() : String {
        mBlueAdapter = BluetoothAdapter.getDefaultAdapter();
        if (!mBlueAdapter.isEnabled)
        {
            showToast("Включаем блютуз...")
            val intent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
            startActivityForResult(intent, REQUEST_ENABLE_BT)
            return "Статус: Включено"
        }
        return "error"
    }

    private fun turnOffBluetooth() : String {
        mBlueAdapter = BluetoothAdapter.getDefaultAdapter();
        if (mBlueAdapter.isEnabled)
        {
            mBlueAdapter.disable()
            showToast("Turning Bluetooth Off")
            return "Статус: Отключено"
        }
        return "error"
    }

    private fun switchWifi() {
        wifi.isWifiEnabled = !wifi.isWifiEnabled
        showToast(if (!wifi.isWifiEnabled) "Вайфай включен" else "Вайфай выключен");
    }

    private fun showToast(msg: String) {
        Toast.makeText(this, msg, Toast.LENGTH_SHORT).show()
    }
}