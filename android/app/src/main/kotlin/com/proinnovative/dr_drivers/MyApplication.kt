package com.proinnovative.dr_drivers

import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.embedding.android.FlutterApplication

class MyApplication : FlutterApplication(), PluginRegistrantCallback {
    fun onCreate() {
        super.onCreate()
//        GeofencingService.setPluginRegistrant(this)
    }

    fun registerWith(registry: PluginRegistry) {
        GeneratedPluginRegistrant.registerWith(registry);
    }
}