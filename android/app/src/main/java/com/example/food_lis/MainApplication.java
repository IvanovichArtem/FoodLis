package com.example.food_lis;

import android.app.Application;

import com.yandex.mapkit.MapKitFactory;

public class MainApplication extends Application {
  @Override
  public void onCreate() {
    super.onCreate();
    MapKitFactory.setApiKey("daf12e69-7075-402b-9e60-6f836a29c3ec");
  }
}